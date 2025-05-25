import 'package:e_commerce_data/auth_data/auth_api_client.dart';
import 'package:e_commerce_data/auth_data/models/models.dart';

class AuthRepository {
  AuthRepository({AuthApiClient? authApi})
      : _authApi = authApi ?? AuthApiClient();
  final AuthApiClient _authApi;

  Future<RegisterResponseModel> registerUser(UserModel userData) async =>
      _authApi.registerUser(userData);
}
