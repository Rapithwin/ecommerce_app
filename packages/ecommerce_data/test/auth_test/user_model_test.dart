import 'package:e_commerce_data/auth_data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel', () {
    test('fromJson() should correctly create UserModel from JSON', () {
      final Map<String, dynamic> json = {
        'id': '123',
        'email': 'test@test.com',
        'firstName': 'John',
        'lastName': 'Doe',
        'address': '123 Street',
        'phoneNumber': '1234567890',
      };

      final UserModel user = UserModel.fromJson(json);

      expect(user.id, '123');
      expect(user.email, 'test@test.com');
      expect(user.firstName, 'John');
      expect(user.lastName, 'Doe');
      expect(user.address, '123 Street');
      expect(user.phoneNumber, '1234567890');
    });

    test('toJson() should return correct JSON map', () {
      final UserModel user = UserModel(
        email: 'test@test.com',
        password: 'password123',
        firstName: 'John',
        lastName: 'Doe',
        address: '123 Street',
        phoneNumber: '1234567890',
      );

      final Map<String, dynamic> json = user.toJson();

      expect(json['email'], 'test@test.com');
      expect(json['password'], 'password123');
      expect(json['firstName'], 'John');
      expect(json['lastName'], 'Doe');
      expect(json['address'], '123 Street');
      expect(json['phoneNumber'], '1234567890');
    });

    test('fromJson() should handle null values', () {
      final Map<String, dynamic> json = {
        'id': null,
        'email': null,
        'firstName': null,
        'lastName': null,
        'address': null,
        'phoneNumber': null,
      };

      final UserModel user = UserModel.fromJson(json);

      expect(user.id, null);
      expect(user.email, null);
      expect(user.firstName, null);
      expect(user.lastName, null);
      expect(user.address, null);
      expect(user.phoneNumber, null);
    });
  });
}
