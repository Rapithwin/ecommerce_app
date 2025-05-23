class RegisterRequestModel {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String address;
  final String phoneNumber;

  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "address": address,
        "phoneNumber": phoneNumber,
      };
}

class RegisterResponseModel {
  final bool isSuccess;
  final String? error;

  RegisterResponseModel({
    required this.isSuccess,
    required this.error,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      isSuccess: json["isSuccess"],
      error: json["error"],
    );
  }
}
