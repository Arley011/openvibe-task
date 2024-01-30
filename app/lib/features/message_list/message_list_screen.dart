import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvibe_app/common/widgets/error_placeholder.dart';
import 'package:openvibe_app/domain/models/message.dart';
import 'package:openvibe_app/features/message_detail/message_detail_screen.dart';
import 'package:openvibe_app/features/message_list/cubit/message_list_cubit.dart';
import 'package:openvibe_app/features/message_list/widgets/widgets.dart';

/// Screen to display a list of messages.
class MessageListScreen extends StatefulWidget {
  const MessageListScreen({
    super.key,
  });

  static PageRoute route() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => BlocProvider(
        create: (_) => MessageListCubit(),
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
        if (state.messages.isEmpty) {
          if (state.messagesRequest != null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: ErrorPlaceholder(
              title: 'No messages',
              message: 'App failed to load messages. Please, try to reload',
              onReload: context.read<MessageListCubit>().loadMessages,
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          controller: _scrollController,
          itemCount: state.messagesRequest != null
              ? state.messages.length + 1
              : state.messages.length,
          itemBuilder: (context, index) {
            final loaderIndex = state.messages.length;
            if (index == loaderIndex) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
              );
            }

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
    Navigator.push(context, MessageDetailScreen.route(message.id));
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_loadMore)
      ..dispose();

    super.dispose();
  }
}
