import 'package:e_commerce_data/auth_data/auth_api_client.dart';
import 'package:e_commerce_data/auth_data/models/models.dart';

class AuthRepository {
  AuthRepository({AuthApiClient? authApi})
      : _authApi = authApi ?? AuthApiClient();
  final AuthApiClient _authApi;

  Future<RegisterResponseModel> registerUser(UserModel userData) async =>
      await _authApi.registerUser(userData);

  Future<LoginResponseModel> loginUser(UserModel userData) async =>
      await _authApi.loginUser(userData);

  Future<UserModel> getUser(String token) async =>
      await _authApi.getUser(token);

  Future<UserModel> updateUser(UserModel userData, String token) async =>
      await _authApi.updateUser(userData, token);
}
