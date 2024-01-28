import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:openvibe_app/common/constants.dart';
import 'package:openvibe_app/common/theme.dart';
import 'package:openvibe_app/features/welcome/welcome_screen.dart';

void main() {
  runZonedGuarded(() {
    runApp(const OpenvibeApp());
  }, (error, stackTrace) {
    log(
      'runZonedGuarded: Caught error in my root zone.',
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
