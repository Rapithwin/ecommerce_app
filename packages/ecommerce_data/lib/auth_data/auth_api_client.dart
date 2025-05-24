import 'dart:convert';
import 'dart:developer' show log;

import 'package:e_commerce_data/auth_data/models/models.dart';
import 'package:e_commerce_data/data_constants.dart';
import 'package:http/http.dart' as http;

class AuthApiClient {
  AuthApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  final _usersEndpoint = "api/users";

  Future<RegisterResponseModel> registerUser(UserModel userData) async {
    try {
      final registerRequest = Uri.http(
        Constants.authority,
        "$_usersEndpoint/register",
      );

      final registerResponse = await _httpClient.post(
        registerRequest,
        body: userData.toJson(),
      );

      final registerJson =
          jsonDecode(registerResponse.body) as Map<String, dynamic>;
      final result = RegisterResponseModel.fromJson(registerJson);

      return result;
    } catch (error, stacktrace) {
      log("Error during api call $error");
      log("Stacktrace $stacktrace");
      rethrow;
    }
  }

  Future<LoginResponseModel> loginUser(UserModel userData) async {
    try {
      final loginRequest = Uri.http(
        Constants.authority,
        "$_usersEndpoint/login",
      );

      final loginResponse = await _httpClient.post(
        loginRequest,
        body: userData.toJson(),
      );

      final loginJson = jsonDecode(loginResponse.body) as Map<String, dynamic>;
      final result = LoginResponseModel.fromJson(loginJson);

      return result;
    } catch (error, stacktrace) {
      log("Error during api call $error");
      log("Stacktrace $stacktrace");
      rethrow;
    }
  }

  Future<UserModel> getUser() async {
    try {
      final userRequest = Uri.http(
        Constants.authority,
        "$_usersEndpoint/me",
      );

      final userResponse = await _httpClient.get(userRequest);

      final userJson = jsonDecode(userResponse.body) as Map<String, dynamic>;
      final result = UserModel.fromJson(userJson);

      return result;
    } catch (error, stacktrace) {
      log("Error during api call $error");
      log("Stacktrace $stacktrace");
      rethrow;
    }
  }
}
