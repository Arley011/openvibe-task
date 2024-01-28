import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvibe_app/domain/models/message.dart';
import 'package:openvibe_app/domain/services/server_service.dart';
import 'package:openvibe_app/features/message_detail/message_detail_screen.dart';
import 'package:openvibe_app/features/message_list/cubit/message_list_cubit.dart';
import 'package:uuid/uuid.dart';

class MessageListScreen extends StatelessWidget {
  const MessageListScreen({
    super.key,
  });

  static PageRoute route() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const MessageListScreen(),
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  final _uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => MessageListCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Openvibe'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            ServerService().send(['get', _uuid.v4(), 10]);
          },
        ),
        body: BlocBuilder<MessageListCubit, MessageListState>(
            builder: (context, state) {
          return ListView.builder(
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final message = state.messages[index];
              return ListTile(
                title: Text(message.nickname),
                subtitle: Text(message.message),
                leading: Text(
                  message.icon,
                  style: const TextStyle(fontSize: 24),
                ),
                onTap: () => _handleMessagePressed(context, message),
              );
            },
          );
        }),
      ),
    );
  }

  void _handleMessagePressed(BuildContext context, Message message) {
    Navigator.push(context, MessageDetailScreen.route(message));
  }
}
