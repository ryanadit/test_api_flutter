import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_flutter/api/api_service.dart';
import 'package:test_api_flutter/model/user_model.dart';

import 'user_data_bloc_state.dart';



class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserBlocInitialState());

  void initData() async {
    emit(UserBlocInitialState());
    try {
      final response = await ApiService.posts();
      if(response != "NetworkError") {
        final list = response as List;
        emit(UserBlocLoadedState(list.map((e) => UserModel.fromJson(e)).toList()));
      } else {
        emit(UserBlocFailedState());
      }
    }catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(UserBlocFailedState());
    }

  }

  void getSearchData(String id) async {
    emit(UserBlocInitialState());
    try {
      final response = await ApiService.postsSearch(id);
      if(response != "NetworkError") {
        List? list = [];
        list.add(response);
        emit(UserBlocLoadedState(list.map((e) => UserModel.fromJson(e)).toList()));
      } else {
        emit(UserBlocFailedState());
      }
    }catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(UserBlocFailedState());
    }

  }

}