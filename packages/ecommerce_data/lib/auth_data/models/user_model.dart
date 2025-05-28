class UserModel {
  final String? id;
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? phoneNumber;

  UserModel({
    this.id,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.address,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (email != null) map["email"] = email;
    if (password != null) map["password"] = password;
    if (firstName != null) map["firstName"] = firstName;
    if (lastName != null) map["lastName"] = lastName;
    if (address != null) map["address"] = address;
    if (phoneNumber != null) map["phoneNumber"] = phoneNumber;
    return map;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
