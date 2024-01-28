import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvibe_app/domain/models/message.dart';
import 'package:openvibe_app/features/message_detail/message_detail_screen.dart';
import 'package:openvibe_app/features/message_list/cubit/message_list_cubit.dart';
import 'package:openvibe_app/features/message_list/widgets/widgets.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({
    super.key,
  });

  static PageRoute route() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => BlocProvider(
        create: (_) => MessageListCubit()..loadMessages(),
        child: const MessageListScreen(),
      ),
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Openvibe'),
      ),
      body: BlocBuilder<MessageListCubit, MessageListState>(
          builder: (context, state) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          controller: _scrollController,
          itemCount: state.messages.length,
          itemBuilder: (context, index) {
            final message = state.messages[index];
            return MessageListTile(
              message,
              showDivider: index > 0,
              onMessagePressed: _handleMessagePressed,
            );
          },
        );
      }),
    );
  }

  void _loadMore() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      context.read<MessageListCubit>().loadMessages();
    }
  }

  void _handleMessagePressed(BuildContext context, Message message) {
    Navigator.push(context, MessageDetailScreen.route(message));
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }
}
