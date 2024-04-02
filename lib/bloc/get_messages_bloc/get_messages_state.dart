part of 'get_messages_bloc.dart';

enum GetMessagesStatus {
  initial,
  loading,
  loaded,
  error,
  receiveMessage,
  sendMessage
}

class GetMessagesState extends Equatable {
  final GetMessagesStatus messagesStatus;
  final List<dynamic> messages;

  const GetMessagesState(
      {required this.messagesStatus, required this.messages});

  factory GetMessagesState.initial() {
    return const GetMessagesState(
        messagesStatus: GetMessagesStatus.initial, messages: []);
  }

  GetMessagesState copyWith(
      {GetMessagesStatus? messagesStatus, List<dynamic>? messages}) {
    return GetMessagesState(
        messagesStatus: messagesStatus ?? this.messagesStatus,
        messages: messages ?? this.messages);
  }

  @override
  List<Object?> get props => [messagesStatus, messages];
}
