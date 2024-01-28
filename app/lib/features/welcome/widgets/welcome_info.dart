import 'package:flutter/material.dart';

class WelcomeInfo extends StatelessWidget {
  const WelcomeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Welcome',
          style: theme.textTheme.displayLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'This is an Openvibe demo app made by Artur',
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
