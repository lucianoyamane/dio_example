import 'package:dio_example/api/dio_api.dart';
import 'package:dio_example/models/user.dart';

class UserService {
  static UserService? _instance;

  factory UserService() => _instance ??= UserService._();

  UserService._();

  Future<User> getUser({required String id}) async {
    var response = await Api().dio.get('/users/$id');

    return User.fromJson(response.data);
  }
}