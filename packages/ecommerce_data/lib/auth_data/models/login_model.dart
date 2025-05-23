import 'package:e_commerce_data/auth_data/models/models.dart';

class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

class LoginResponseModel {
  final bool isSuccess;
  final LoginData? data;
  final String? error;

  LoginResponseModel({
    required this.isSuccess,
    this.data,
    this.error,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      isSuccess: json['isSuccess'] ?? false,
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
      error: json['error'],
    );
  }
}

class LoginData {
  final String token;
  final DateTime expiration;
  final UserModel user;

  LoginData({
    required this.token,
    required this.expiration,
    required this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'],
      expiration: DateTime.parse(json['expiration']),
      user: UserModel.fromJson(json['user']),
    );
  }
}
