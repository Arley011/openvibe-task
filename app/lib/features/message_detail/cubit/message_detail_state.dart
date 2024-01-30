part of 'message_detail_cubit.dart';

abstract class MessageDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class MessageDetailInitial extends MessageDetailState {}

class MessageDetailLoading extends MessageDetailState {}

class MessageDetailLoaded extends MessageDetailState {
  MessageDetailLoaded(this.message);

  final Message message;

  @override
  List<Object> get props => [message];
}

class MessageDetailError extends MessageDetailState {
  MessageDetailError(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}
