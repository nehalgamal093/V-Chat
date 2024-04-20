part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class Register extends RegisterEvent {
  final String fullName;
  final String username;
  final String password;
  final String confirmPassword;
  final String gender;
  const Register({
    required this.fullName,
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.gender,
  });

  @override
  List<Object> get props =>
      [fullName, username, password, confirmPassword, gender];
}
