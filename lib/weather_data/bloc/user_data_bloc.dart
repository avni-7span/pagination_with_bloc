import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pagination_bloc/weather_data/models/user_model.dart';

part 'user_data_event.dart';

part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc() : super(const UserDataState()) {
    on<UserDataFetched>(onDataFetched);
    on<LoadMoreData>(_onLoadMoreData);
  }

  Future<void> onDataFetched(
    UserDataFetched event,
    Emitter<UserDataState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      final userData = await _fetchData(1);
      return emit(
        state.copyWith(
          status: UserDataStatus.success,
          userModel: userData,
          hasReachedMax: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: UserDataStatus.failure));
    }
  }

  FutureOr<void> _onLoadMoreData(
    LoadMoreData event,
    Emitter<UserDataState> emit,
  ) async {
    print('in else');
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: UserDataStatus.loading));
    final userData = await _fetchData(state.pageNumber);

    userData?.length == 0
        ? emit(state.copyWith(hasReachedMax: true))
        : emit(
            state.copyWith(
                status: UserDataStatus.success,
                hasReachedMax: false,
                userModel: [...state.userModel, ...?userData],
                pageNumber: state.pageNumber + 1),
          );
  }

  Future<List<Results>?> _fetchData(int pageNumber) async {
    try {
      final response = await Dio().get(
          'https://randomuser.me/api/?page=$pageNumber&results=15&seed=abc');
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['results'] != null) {
          List<Results> resultList = [];
          for (Map<String, dynamic> e in responseData['results']) {
            resultList.add(Results.fromJson(e));
          }
          return resultList;
        }
      }
    } catch (e) {}
    return null;
  }
}
