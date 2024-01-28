import 'package:flutter/material.dart';
import 'package:openvibe_app/domain/models/message.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

typedef MessagePressedCallback = void Function(
  BuildContext context,
  Message message,
);

class MessageListTile extends StatelessWidget {
  const MessageListTile(
    this.message, {
    this.showDivider = true,
    required this.onMessagePressed,
    super.key,
  });

  final Message message;
  final bool showDivider;
  final MessagePressedCallback onMessagePressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onMessagePressed(context, message),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              message.icon,
              style: const TextStyle(fontSize: 32),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
              decoration: showDivider
                  ? BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: theme.dividerColor,
                        ),
                      ),
                    )
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        message.nickname,
                        style: theme.textTheme.titleSmall,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.circle, size: 4),
                      ),
                      Timeago(
                        date: message.createdAt,
                        locale: 'en_short',
                        builder: (context, timeago) {
                          return Text(
                            timeago,
                            style: theme.textTheme.labelSmall,
                          );
                        },
                      ),
                    ],
                  ),
                  Text(
                    message.message,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
