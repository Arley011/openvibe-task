import 'package:flutter/material.dart';
import 'package:openvibe_app/features/welcome/cubit/welcome_cubit.dart';

class WelcomeStatus extends StatelessWidget {
  const WelcomeStatus({
    super.key,
    required this.state,
    required this.onRetry,
  });

  final WelcomeState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      ),
      child: state is! WelcomeError
          ? Column(
              key: const ValueKey('loading'),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: state is! WelcomeSuccess
                        ? const SizedBox(
                            width: 48,
                            height: 48,
                            child: CircularProgressIndicator(),
                          )
                        : const Icon(Icons.check, size: 48),
                  ),
                ),
                Text(
                  state is! WelcomeSuccess
                      ? 'Trying to connect to the server'
                      : 'Connected 🚀',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            )
          : Column(
              key: const ValueKey('error'),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Icon(Icons.error, size: 48),
                ),
                Text(
                  'Failed to connect to the server.\n'
                  'Please make sure the server is running and try again.',
                  style: theme.textTheme.bodyMedium,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      onPressed: onRetry,
                      child: const Text('Try again'),
                    )),
              ],
            ),
    );
  }
}
