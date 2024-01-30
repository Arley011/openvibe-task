import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvibe_app/domain/models/message.dart';
import 'package:openvibe_app/domain/models/message_request.dart';
import 'package:openvibe_app/domain/models/optional.dart';
import 'package:openvibe_app/domain/services/server_service.dart';
import 'package:openvibe_app/domain/services/shared_preferences_service.dart';
import 'package:uuid/uuid.dart';

part 'message_list_state.dart';

/// Cubit for the message list screen.
/// Subscribes to the [ServerService.onMessage] stream to receive new messages.
class MessageListCubit extends Cubit<MessageListState> {
  MessageListCubit() : super(const MessageListState.initial()) {
    _messagesStream = ServerService.onMessage.listen(_handleMessage);
    loadMessages();
  }

  /// Number of messages to load per request.
  static const _messagesPerPage = 20;
  static const _messageRequestTimeout = Duration(seconds: 5);

  final _uuid = const Uuid();

  /// Stream subscription for the messages stream.
  late final StreamSubscription<dynamic> _messagesStream;

  /// Loads messages from the server.
  /// Creates [MessagesRequest] to track progress of the request and blocks
  /// loading of new messages until the previous request is complete.
  /// If [_messagesPerPage] messages were not received within [_messageRequestTimeout],
  /// the request is being cleared automatically, but all received messages will be
  /// precessed. All processed messages are saved to the state and to the cache.
  void loadMessages() async {
    if (state.messagesRequest != null) {
      return;
    }

    final requestId = _uuid.v4();
    final request = MessagesRequest(
        requestId: requestId,
        desiredCount: _messagesPerPage,
        timeoutTimer: _timeoutTimer(requestId));

    emit(state.copyWith(
      messagesRequest: request.toOptional,
    ));

    ServerService().send(['get', request.requestId, request.desiredCount]);
  }

  /// Handles a message received from the server.
  /// Saves the message to the state and to the cache.
  /// Updates message request progress.
  Future<void> _handleMessage(dynamic message) async {
    try {
      final decodedJson = jsonDecode(message) as List;
      final decodedMessage =
          Message.fromJson(decodedJson[1] as Map<String, dynamic>);

      final requestUpdate = state.messagesRequest?.incrementReceivedCount();
      emit(state.copyWith(
        messages: [...state.messages, decodedMessage],
        messagesRequest:
            ((requestUpdate?.isComplete ?? false) ? null : requestUpdate)
                .toOptional,
      ));
      await SharedPreferencesService.saveMessage(decodedMessage);
    } catch (e, st) {
      log('Error handling message', error: e, stackTrace: st);
    }
  }

  /// Request timer that clears the request if it is not complete
  /// within [_messageRequestTimeout].
  /// The timer is cancelled when request becomes completed in
  /// [MessagesRequest.incrementReceivedCount].
  Timer _timeoutTimer(String requestId) {
    return Timer(_messageRequestTimeout, () {
      if (isClosed) {
        return;
      }

      log('Request $requestId timed out');
      emit(state.copyWith(
        messagesRequest: null.toOptional,
      ));
    });
  }

  @override
  Future<void> close() {
    _messagesStream.cancel();

    return super.close();
  }
}
