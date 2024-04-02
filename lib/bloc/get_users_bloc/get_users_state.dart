part of 'get_users_bloc.dart';

enum GetUsersStatus { initial, loading, loaded, error }

class GetUsersState extends Equatable {
  final GetUsersStatus getUsersStatus;
  final List<dynamic> userModel;

  const GetUsersState({required this.getUsersStatus, required this.userModel});

  factory GetUsersState.initial() {
    return const GetUsersState(
        getUsersStatus: GetUsersStatus.initial, userModel: []);
  }

  GetUsersState copyWith(
      {GetUsersStatus? getUsersStatus, List<dynamic>? userModel}) {
    return GetUsersState(
        getUsersStatus: getUsersStatus ?? this.getUsersStatus,
        userModel: userModel ?? this.userModel);
  }

  @override
  List<Object?> get props => [getUsersStatus, userModel];
}
