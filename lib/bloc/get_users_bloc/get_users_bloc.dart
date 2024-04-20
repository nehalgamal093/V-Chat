// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:v_chat/services/dio/dio_helper.dart';
part 'get_users_event.dart';
part 'get_users_state.dart';

class GetUsersBloc extends Bloc<GetUsersEvent, GetUsersState> {
  GetUsersBloc() : super(GetUsersState.initial()) {
    on<GetUsers>(
      (event, emit) async {
        emit(state.copyWith(getUsersStatus: GetUsersStatus.loading));
        try {
          var val = await DioHelpers.getData(endPoints: 'users');
          List<dynamic> users = val.data.map((e) => e).toList();

          emit(state.copyWith(
              getUsersStatus: GetUsersStatus.loaded, userModel: users));
        } catch (e) {
          emit(state.copyWith(getUsersStatus: GetUsersStatus.error));
          print('Error from get users bloc ${e}');
        }
      },
    );
    on<Logout>(
      (event, emit) async {
        try {
          emit(state
              .copyWith(getUsersStatus: GetUsersStatus.loaded, userModel: []));
        } catch (e) {
          emit(state.copyWith(getUsersStatus: GetUsersStatus.error));
          print('Error from get users bloc  logout ${e}');
        }
      },
    );
  }
}
