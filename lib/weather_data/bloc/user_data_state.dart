part of 'user_data_bloc.dart';

enum UserDataStatus { initial, loading, success, failure }

final class UserDataState extends Equatable {
  const UserDataState({
    this.status = UserDataStatus.initial,
    this.userModel = const <Results>[],
    this.hasReachedMax = false,
    this.pageNumber = 1,
  });

  final UserDataStatus status;
  final List<Results> userModel;
  final bool hasReachedMax;
  final int pageNumber;

  UserDataState copyWith(
      {List<Results>? userModel,
      UserDataStatus? status,
      bool? hasReachedMax,
      int? pageNumber}) {
    return UserDataState(
        userModel: userModel ?? this.userModel,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status,
        pageNumber: pageNumber ?? this.pageNumber);
  }

  @override
  String toString() {
    return 'UserDataState{status: $status, userModel: ${userModel.length}, hasReachedMax: $hasReachedMax}';
  }

  @override
  List<Object?> get props => [status, userModel, hasReachedMax, pageNumber];
}
