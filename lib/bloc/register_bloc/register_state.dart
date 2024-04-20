part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, loaded, error }

class RegisterState extends Equatable {
  final RegisterStatus registerStatus;
  final dynamic response;

  const RegisterState({required this.registerStatus, required this.response});

  factory RegisterState.initial() {
    return const RegisterState(
        registerStatus: RegisterStatus.initial, response: '');
  }

  RegisterState copyWith({RegisterStatus? registerStatus, dynamic response}) {
    return RegisterState(
        registerStatus: registerStatus ?? this.registerStatus,
        response: response ?? this.response);
  }

  @override
  List<Object?> get props => [registerStatus, response];
}
