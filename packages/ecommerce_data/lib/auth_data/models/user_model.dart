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

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "address": address,
        "phoneNumber": phoneNumber,
      };
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
