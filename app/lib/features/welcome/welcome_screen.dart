import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvibe_app/features/message_list/message_list_screen.dart';
import 'package:openvibe_app/features/welcome/cubit/welcome_cubit.dart';
import 'package:openvibe_app/features/welcome/widgets/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeCubit()..load(),
      child: Scaffold(
        body: BlocConsumer<WelcomeCubit, WelcomeState>(
          listener: (context, state) {
            if (state is WelcomeSuccess) {
              _handleSuccess(context);
            }
          },
          builder: (context, state) {
            return DefaultTextStyle.merge(
              textAlign: TextAlign.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Expanded(
                    child: WelcomeInfo(),
                  ),
                  Expanded(
                    child: WelcomeStatus(
                      state: state,
                      onRetry: context.read<WelcomeCubit>().load,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleSuccess(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(context, MessageListScreen.route());
    });
  }
}
