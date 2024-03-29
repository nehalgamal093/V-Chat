import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_chat/services/auth/auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Auth auth;
  LoginBloc({required this.auth}) : super(LoginState.initial()) {
    on<Login>((event, emit) async {
      emit(state.copyWith(loadingStatus: LoginStatus.loading));
      try {
        final getLoginResponse =
            await auth.login(event.username, event.password);
        emit(state.copyWith(
            loadingStatus: LoginStatus.loaded, response: getLoginResponse));
      } catch (e) {
        emit(state.copyWith(loadingStatus: LoginStatus.error));
      }
    });
  }
}
