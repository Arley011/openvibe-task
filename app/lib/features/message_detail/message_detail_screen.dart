import 'package:flutter/material.dart';
import 'package:openvibe_app/domain/models/message.dart';

class MessageDetailScreen extends StatelessWidget {
  const MessageDetailScreen({
    super.key,
    required this.message,
  });

  static PageRoute route(Message message) {
    return MaterialPageRoute(
      builder: (_) => MessageDetailScreen(message: message),
    );
  }

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(message.icon, style: const TextStyle(fontSize: 32)),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(message.nickname),
                      Text(message.createdAt.toString()),
                    ],
                  ),
                ),
              ],
            ),
            Text(message.message),
          ],
        ),
      ),
    );
  }
}
