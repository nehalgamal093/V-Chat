import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:v_chat/services/chat/chat.dart';

part 'send_msg_event.dart';
part 'send_msg_state.dart';

class SendMsgBloc extends Bloc<SendMsgEvent, SendMsgState> {
  Chat chat;
  SendMsgBloc({required this.chat}) : super(SendMsgState.initial()) {
    on<SendMessage>((event, emit) async {
      emit(state.copyWith(sendMsgStatus: SendMsgStatus.loading));
      try {
        final getMsgResponse = await chat.sendMessage(event.msg, event.id);
        emit(state.copyWith(
            sendMsgStatus: SendMsgStatus.loaded, response: getMsgResponse));
      } catch (e) {
        emit(state.copyWith(sendMsgStatus: SendMsgStatus.error));
      }
    });
  }
}
