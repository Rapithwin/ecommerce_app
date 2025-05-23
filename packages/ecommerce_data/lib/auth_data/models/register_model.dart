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
