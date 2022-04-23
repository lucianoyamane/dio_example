import 'package:dio_example/pages/bloc/user_data_state.dart';
import 'package:dio_example/service/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class GetUserDataEvent {
  final String id;

  GetUserDataEvent(this.id);
}

class UserDataBloc extends Bloc<GetUserDataEvent, UserDataState> {
  UserDataBloc() : super(UserDataInitial()){
    final UserService _userService = UserService();
    on<GetUserDataEvent>((event, emit) async {
      emit(UserDataLoading());
      final userData = await _userService.getUser(id: event.id);
      emit(UserDataLoaded(userData.data));
    });
  }

}