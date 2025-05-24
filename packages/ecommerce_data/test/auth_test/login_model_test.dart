import 'package:test/test.dart';
import 'package:e_commerce_data/auth_data/models/models.dart';

void main() {
  group('loginModel', () {
    group('LoginRequestModel', () {
      test('toJson() should return correct map', () {
        final model = LoginRequestModel(
            email: 'test@example.com', password: 'password123');

        expect(model.toJson(),
            {'email': 'test@example.com', 'password': 'password123'});
      });
    });

    group('LoginResponseModel', () {
      test('fromJson() with success response should parse correctly', () {
        final json = {
          'isSuccess': true,
          'data': {
            'token': 'abc123',
            'expiration': '2023-12-31T23:59:59Z',
            'user': {
              'id': '1',
              'firstName': 'John',
              'lastName': 'Doe',
              'email': 'test@example.com'
            }
          }
        };

        final model = LoginResponseModel.fromJson(json);

        expect(model.isSuccess, true);
        expect(model.error, null);
        expect(model.data?.token, 'abc123');
        expect(model.data?.expiration, DateTime.parse('2023-12-31T23:59:59Z'));
        expect(model.data?.user.id, '1');
        expect(model.data?.user.firstName, 'John');
        expect(model.data?.user.lastName, 'Doe');
        expect(model.data?.user.email, 'test@example.com');
      });

      test('fromJson() with error response should parse correctly', () {
        final json = {'isSuccess': false, 'error': 'Invalid credentials'};

        final model = LoginResponseModel.fromJson(json);

        expect(model.isSuccess, false);
        expect(model.data, null);
        expect(model.error, 'Invalid credentials');
      });
    });

    group('LoginData', () {
      test('fromJson() should parse correctly', () {
        final json = {
          'token': 'xyz789',
          'expiration': '2023-12-31T23:59:59Z',
          'user': {
            'id': '2',
            'firstName': 'John',
            'lastName': 'Doe',
            'email': 'john@example.com'
          }
        };

        final model = LoginData.fromJson(json);

        expect(model.token, 'xyz789');
        expect(model.expiration, DateTime.parse('2023-12-31T23:59:59Z'));
        expect(model.user.id, '2');
        expect(model.user.firstName, 'John');
        expect(model.user.lastName, 'Doe');
        expect(model.user.email, 'john@example.com');
      });
    });
  });
}
