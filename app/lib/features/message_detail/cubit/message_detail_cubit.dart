import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvibe_app/domain/models/message.dart';
import 'package:openvibe_app/domain/services/shared_preferences_service.dart';

part 'message_detail_state.dart';

/// Cubit for the message detail screen.
class MessageDetailCubit extends Cubit<MessageDetailState> {
  MessageDetailCubit() : super(MessageDetailInitial());

  void loadMessage(String id) async {
    try {
      emit(MessageDetailLoading());

      final message = await SharedPreferencesService.getMessage(id);
      if (message == null) {
        emit(MessageDetailError('Message not found'));
      } else {
        emit(MessageDetailLoaded(message));
      }
    } catch (e, st) {
      log('Error loading message $id', error: e, stackTrace: st);
      emit(MessageDetailError(e));
    }
  }
}
