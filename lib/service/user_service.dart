import 'package:dio_example/api/dio_api.dart';
import 'package:dio_example/models/user.dart';
import 'package:dio_example/models/user_info.dart';

class UserService {
  static UserService? _instance;

  factory UserService() => _instance ??= UserService._();

  UserService._();

  Future<User> getUser({required String id}) async {
    var response = await Api().dio.get('/users/$id');

    return User.fromJson(response.data);
  }

  Future<UserInfo> createUser({required UserInfo userInfo}) async {
    var response = await Api().dio.post('/users', data: userInfo.toJson());

    return UserInfo.fromJson(response.data);
  }
}