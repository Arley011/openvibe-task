part of 'message_list_cubit.dart';

class MessageListState extends Equatable {
  const MessageListState._({
    this.messages = const [],
    this.messagesRequest,
  });

  const MessageListState.initial() : this._();

  final List<Message> messages;
  final MessagesRequest? messagesRequest;

  MessageListState copyWith({
    List<Message>? messages,
    Optional<MessagesRequest?>? messagesRequest,
  }) {
    return MessageListState._(
      messages: messages ?? this.messages,
      messagesRequest: Optional.resolve(messagesRequest, this.messagesRequest),
    );
  }

  @override
  List<Object?> get props => [
        messages,
        messagesRequest,
      ];
}
