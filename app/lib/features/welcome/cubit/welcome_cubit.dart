import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvibe_app/domain/services/server_service.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(const WelcomeInitial());

  void load() async {
    emit(const WelcomeLoading());
    ServerService.init(
      forceInit: true,
    );

    // Simulate loading
    await Future.delayed(const Duration(seconds: 2));
    final isConnected =
        ServerService.isInitialized ? await ServerService().isConnected : false;
    if (isConnected) {
      log('Connected to server');
      emit(const WelcomeSuccess());
    } else {
      log('Failed to connect to server');
      emit(const WelcomeError());
    }
  }
}
