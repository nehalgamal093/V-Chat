import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:v_chat/services/auth/auth.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  Auth auth;
  RegisterBloc({required this.auth}) : super(RegisterState.initial()) {
    on<Register>((event, emit) async {
      emit(state.copyWith(registerStatus: RegisterStatus.loading));
      try {
        final getRegisterResponse = await auth.register(
            event.username,
            event.password,
            event.confirmPassword,
            event.gender,
            event.fullName);
        emit(state.copyWith(
            registerStatus: RegisterStatus.loaded,
            response: getRegisterResponse));
      } catch (e) {
        emit(state.copyWith(registerStatus: RegisterStatus.error));
      }
    });
  }
}
