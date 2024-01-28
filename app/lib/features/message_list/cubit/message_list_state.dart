part of 'message_list_cubit.dart';

class MessageListState extends Equatable {
  const MessageListState._({
    this.messages = const [],
  });

  const MessageListState.initial() : this._();

  final List<Message> messages;

  MessageListState copyWith({
    List<Message>? messages,
  }) {
    return MessageListState._(
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [
        messages,
      ];
}
