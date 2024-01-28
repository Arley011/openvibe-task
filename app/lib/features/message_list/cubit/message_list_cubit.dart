import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvibe_app/domain/models/message.dart';
import 'package:openvibe_app/domain/services/server_service.dart';

part 'message_list_state.dart';

class MessageListCubit extends Cubit<MessageListState> {
  MessageListCubit() : super(const MessageListState.initial()) {
    _messagesStream = ServerService.onMessage.listen(_handleMessage);
  }

  late final StreamSubscription<dynamic> _messagesStream;

  void _handleMessage(dynamic message) {
    try {
      final decodedJson = jsonDecode(message) as List;
      final decodedMessage =
          Message.fromJson(decodedJson[1] as Map<String, dynamic>);
      emit(
        state.copyWith(
          messages: [
            ...state.messages,
            decodedMessage,
          ],
        ),
      );
    } catch (e, st) {
      log('Error handling message', error: e, stackTrace: st);
    }
  }

  @override
  Future<void> close() {
    _messagesStream.cancel();

    return super.close();
  }
}
