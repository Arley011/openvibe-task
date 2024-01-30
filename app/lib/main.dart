import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:openvibe_app/common/constants.dart';
import 'package:openvibe_app/common/theme.dart';
import 'package:openvibe_app/domain/services/shared_preferences_service.dart';
import 'package:openvibe_app/features/welcome/welcome_screen.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SharedPreferencesService.init();
    runApp(const OpenvibeApp());
  }, (error, stackTrace) {
    log(
      'runZonedGuarded: Caught error in app\'s root zone.',
      error: error,
      stackTrace: stackTrace,
    );
  });
}

class OpenvibeApp extends StatelessWidget {
  const OpenvibeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: lightTheme,
      home: const WelcomeScreen(),
    );
  }
}
