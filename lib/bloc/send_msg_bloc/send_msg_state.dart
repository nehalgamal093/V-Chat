part of 'send_msg_bloc.dart';

enum SendMsgStatus { initial, loading, loaded, error }

class SendMsgState extends Equatable {
  final SendMsgStatus sendMsgStatus;
  final dynamic response;

  const SendMsgState({required this.sendMsgStatus, required this.response});

  factory SendMsgState.initial() {
    return const SendMsgState(
        sendMsgStatus: SendMsgStatus.initial, response: '');
  }

  SendMsgState copyWith({SendMsgStatus? sendMsgStatus, dynamic response}) {
    return SendMsgState(
        sendMsgStatus: sendMsgStatus ?? this.sendMsgStatus,
        response: response ?? this.response);
  }

  @override
  List<Object?> get props => [sendMsgStatus, response];
}
