part of 'login_bloc.dart';

enum LoginStatus { initial, loading, loaded, error }

class LoginState extends Equatable {
  final LoginStatus loadingStatus;
  final dynamic response;

  const LoginState({required this.loadingStatus, required this.response});

  factory LoginState.initial() {
    return const LoginState(loadingStatus: LoginStatus.initial, response: '');
  }

  LoginState copyWith({LoginStatus? loadingStatus, dynamic response}) {
    return LoginState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        response: response ?? this.response);
  }

  @override
  List<Object?> get props => [loadingStatus, response];
}
