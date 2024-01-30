import 'package:flutter/material.dart';

/// Widget to display an error [title] and [message] with a reload button
/// calling [onReload] when pressed.
class ErrorPlaceholder extends StatelessWidget {
  const ErrorPlaceholder({
    super.key,
    required this.title,
    required this.message,
    required this.onReload,
  });

  final String title;
  final String message;
  final VoidCallback onReload;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTextStyle.merge(
      textAlign: TextAlign.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(message),
            ),
            ElevatedButton(
              onPressed: onReload,
              child: const Text('Reload'),
            ),
          ],
        ),
      ),
    );
  }
}
