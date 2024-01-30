import 'package:flutter/material.dart';
import 'package:openvibe_app/common/extensions/date_time_extension.dart';
import 'package:openvibe_app/domain/models/message.dart';

/// Widget that displays the header of the message on the detail screen.
class MessageDetailHeader extends StatelessWidget {
  const MessageDetailHeader({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(message.icon, style: const TextStyle(fontSize: 32)),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.nickname,
                style: theme.textTheme.titleSmall,
              ),
              Row(
                children: [
                  Text(
                    message.createdAt.formattedTime24H,
                    style: theme.textTheme.labelMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      Icons.circle,
                      size: 4,
                      color: theme.textTheme.labelMedium?.color,
                    ),
                  ),
                  Text(
                    message.createdAt.formattedDate,
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
