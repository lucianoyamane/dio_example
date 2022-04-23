import 'package:dio_example/models/data.dart';
import 'package:dio_example/pages/bloc/user_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UserDataEvent{
  Data getData();
}

class GetUserDataEvent extends UserDataEvent {
  final Data data;

  GetUserDataEvent(this.data);

  @override
  Data getData() {
   return data;
  }
}

class UserDataBloc extends Bloc<UserDataEvent, UserDataState?> {
  UserDataBloc() : super(null){
    on<GetUserDataEvent>((event, emit) => emit(UserDataState(event.getData())));
  }

}