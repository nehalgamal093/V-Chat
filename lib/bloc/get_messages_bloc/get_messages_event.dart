part of 'get_messages_bloc.dart';

sealed class GetMessagesEvent extends Equatable {
  const GetMessagesEvent();

  @override
  List<Object> get props => [];
}

class MessagesEvent extends GetMessagesEvent {
  String id;
  MessagesEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class ReceiveMessage extends GetMessagesEvent {
  String id;
  ReceiveMessage({required this.id});

  @override
  List<Object> get props => [id];
}
