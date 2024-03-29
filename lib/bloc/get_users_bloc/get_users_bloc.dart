import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:v_chat/services/dio/dio_helper.dart';

part 'get_users_event.dart';
part 'get_users_state.dart';

class GetUsersBloc extends Bloc<GetUsersEvent, GetUsersState> {
  GetUsersBloc() : super(GetUsersState.initial()) {
    on<GetUsers>((event, emit) async {
      emit(state.copyWith(getUsersStatus: GetUsersStatus.loading));
      try {
        var val = await DioHelpers.getData(endPoints: 'users');
        print('Value is $val');
        emit(state.copyWith(
            getUsersStatus: GetUsersStatus.loaded, response: val));
      } catch (e) {
        print('Error from catch  ${e}');
        emit(state.copyWith(getUsersStatus: GetUsersStatus.error));
      }
    });
  }
}
