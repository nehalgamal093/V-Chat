part of 'send_msg_bloc.dart';

sealed class SendMsgEvent extends Equatable {
  const SendMsgEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends SendMsgEvent {
  final String msg;
  final String id;
  const SendMessage({required this.msg, required this.id});

  @override
  List<Object> get props => [msg, id];
}
