import 'package:flutter/material.dart';
import 'package:openvibe_app/domain/services/server_service.dart';

/// Widget that shows connecting banner when app is not connected to the server
class ConnectionIndicator extends StatelessWidget {
  const ConnectionIndicator({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        child,
        StreamBuilder<bool>(
            stream: ServerService.connectionStream,
            builder: (context, snapshot) {
              final isConnected = snapshot.data == true;
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: !isConnected
                    ? Container(
                        key: const ValueKey('not_connected'),
                        margin: const EdgeInsets.only(top: 24),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: theme.colorScheme.secondary,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: theme.colorScheme.onSecondary,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                'Trying to reconnect...',
                                style: theme.textTheme.titleSmall?.copyWith(
                                    color: theme.colorScheme.onSecondary),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(
                        key: ValueKey('connected'),
                      ),
              );
            }),
      ],
    );
  }
}
