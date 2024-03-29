part of 'get_users_bloc.dart';

enum GetUsersStatus { initial, loading, loaded, error }

class GetUsersState extends Equatable {
  final GetUsersStatus getUsersStatus;
  final dynamic response;

  const GetUsersState({required this.getUsersStatus, required this.response});

  factory GetUsersState.initial() {
    return const GetUsersState(
        getUsersStatus: GetUsersStatus.initial, response: '');
  }

  GetUsersState copyWith({GetUsersStatus? getUsersStatus, dynamic response}) {
    return GetUsersState(
        getUsersStatus: getUsersStatus ?? this.getUsersStatus,
        response: response ?? this.response);
  }

  @override
  List<Object?> get props => [getUsersStatus, response];
}
