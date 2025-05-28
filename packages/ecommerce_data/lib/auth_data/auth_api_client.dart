import 'dart:convert';
import 'dart:developer' show log;
import 'dart:io';

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
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(userData.toJson()),
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

  Future<UserModel> getUser(String token) async {
    try {
      final userRequest = Uri.http(
        Constants.authority,
        "$_usersEndpoint/me",
      );

      final userResponse = await _httpClient.get(
        userRequest,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );

      final responseJson =
          jsonDecode(userResponse.body) as Map<String, dynamic>;
      if (responseJson['isSuccess'] == true && responseJson['data'] != null) {
        final userJson = responseJson['data'] as Map<String, dynamic>;
        final result = UserModel.fromJson(userJson);
        return result;
      }
      throw Exception(responseJson['error'] ?? 'Failed to get user data');
    } catch (error, stacktrace) {
      log("Error during api call $error");
      log("Stacktrace $stacktrace");
      rethrow;
    }
  }

  Future<UserModel> updateUser(UserModel userData, String token) async {
    try {
      final updateRequest = Uri.http(
        Constants.authority,
        "$_usersEndpoint/profile",
      );

      final updateResponse = await _httpClient.put(
        updateRequest,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: userData.toJson(),
      );

      final responseJson =
          jsonDecode(updateResponse.body) as Map<String, dynamic>;
      if (responseJson['isSuccess'] == true && responseJson['data'] != null) {
        final updateJson = responseJson['data'] as Map<String, dynamic>;
        final result = UserModel.fromJson(updateJson);
        return result;
      }
      throw Exception(responseJson['error'] ?? 'Failed to get user data');
    } catch (error, stacktrace) {
      log("Error during api call $error");
      log("Stacktrace $stacktrace");
      rethrow;
    }
  }

  void close() => _httpClient.close();
}
