import 'package:equatable/equatable.dart';
import 'package:test_api_flutter/model/user_model.dart';

abstract class UserDataState extends Equatable {

  const UserDataState();

  @override
  List<Object> get props => [];

}

class UserBlocInitialState extends UserDataState { }

class UserBlocFailedState extends UserDataState { }

class UserBlocLoadedState extends UserDataState {
  final List<UserModel>? data;
  const UserBlocLoadedState(this.data);
  @override
  List<Object> get props => [data!];

}