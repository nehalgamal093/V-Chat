import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_chat/services/dio/dio_helper.dart';
part 'get_messages_event.dart';
part 'get_messages_state.dart';

class GetMessagesBloc extends Bloc<GetMessagesEvent, GetMessagesState> {
  GetMessagesBloc() : super(GetMessagesState.initial()) {
    on<MessagesEvent>((event, emit) async {
      emit(state.copyWith(messagesStatus: GetMessagesStatus.loading));

      try {
        var val = await DioHelpers.getData(endPoints: 'messages/${event.id}');
        List<dynamic> messages = val.data.map((e) => e).toList();
        emit(state.copyWith(
            messagesStatus: GetMessagesStatus.loaded, messages: messages));
      } catch (e) {
        emit(state.copyWith(messagesStatus: GetMessagesStatus.error));
      }
    });
    on<ReceiveMessage>((event, emit) async {
      try {
        var val = await DioHelpers.getData(endPoints: 'messages/${event.id}');
        List<dynamic> messages = val.data.map((e) => e).toList();

        emit(state.copyWith(
            messagesStatus: GetMessagesStatus.receiveMessage,
            messages: messages));
      } catch (e) {
        emit(state.copyWith(messagesStatus: GetMessagesStatus.error));
      }
    });
  }
}
