import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvibe_app/domain/services/server_service.dart';
import 'package:openvibe_app/domain/services/shared_preferences_service.dart';

part 'welcome_state.dart';

/// Cubit for the welcome screen.
class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(const WelcomeInitial());

  void load() async {
    try {
      emit(const WelcomeLoading());

      SharedPreferencesService.clearMessagesCache();
      ServerService.init();

      // Simulate loading
      await Future.delayed(const Duration(seconds: 2));
      final isConnected = ServerService.isInitialized
          ? await ServerService().isConnected
          : false;
      if (isConnected) {
        log('Connected to server');
        emit(const WelcomeSuccess());
        ServerService().enableAutoReconnect();
      } else {
        log('Failed to connect to server');
        emit(const WelcomeError());
      }
    } catch (e, st) {
      log('Error loading app', error: e, stackTrace: st);
      emit(const WelcomeError());
    }
  }
}
