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
  final User user;

  LoginData({
    required this.token,
    required this.expiration,
    required this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'],
      expiration: DateTime.parse(json['expiration']),
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String address;
  final String? phoneNumber;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.address,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
