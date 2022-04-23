import 'package:dio_example/models/data.dart';

abstract class UserDataState {
  final String state;

  UserDataState(this.state);

  getState() {
    return state;
  }
}

class UserDataInitial extends UserDataState {
  UserDataInitial() : super('initial');

}

class UserDataLoading extends UserDataState {
  UserDataLoading() : super('loading');
}

class UserDataLoaded extends UserDataState{
  Data data;

  UserDataLoaded(this.data) : super('loaded');
}