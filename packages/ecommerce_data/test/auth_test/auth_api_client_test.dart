import 'package:e_commerce_data/auth_data/auth_api_client.dart';
import 'package:e_commerce_data/auth_data/models/models.dart';
import 'package:e_commerce_data/data_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client httpClient;
  late AuthApiClient apiClient;

  group('AuthApiClient', () {
    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = AuthApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(AuthApiClient(), isNotNull);
      });
    });

    group('registerUser', () {
      final userData = UserModel(
        email: 'test@example.com',
        password: 'password123',
        firstName: 'John',
        lastName: 'Doe',
      );

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"isSuccess": true}');
        when(() => httpClient.post(any(), body: any(named: 'body')))
            .thenAnswer((_) async => response);

        try {
          await apiClient.registerUser(userData);
        } catch (_) {}

        verify(
          () => httpClient.post(
            Uri.http(Constants.authority, 'api/users/register'),
            body: userData.toJson(),
          ),
        ).called(1);
      });

      test('returns RegisterResponseModel on success', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body)
            .thenReturn('{"isSuccess": true, "error": null}');
        when(() => httpClient.post(any(), body: any(named: 'body')))
            .thenAnswer((_) async => response);

        final actual = await apiClient.registerUser(userData);

        expect(actual, isA<RegisterResponseModel>());
        expect(actual.isSuccess, true);
        expect(actual.error, null);
      });

      test('returns RegisterResponseModel with error on failure', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn(
            '{"isSuccess": false, "error": "Email already exists"}');
        when(() => httpClient.post(any(), body: any(named: 'body')))
            .thenAnswer((_) async => response);

        final actual = await apiClient.registerUser(userData);

        expect(actual.isSuccess, false);
        expect(actual.error, 'Email already exists');
      });
    });

    group('loginUser', () {
      final loginData = UserModel(
        email: 'test@example.com',
        password: 'password123',
      );

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"isSuccess": true}');
        when(() => httpClient.post(any(), body: any(named: 'body')))
            .thenAnswer((_) async => response);

        try {
          await apiClient.loginUser(loginData);
        } catch (_) {}

        verify(
          () => httpClient.post(
            Uri.http(Constants.authority, 'api/users/login'),
            body: loginData.toJson(),
          ),
        ).called(1);
      });

      test('returns LoginResponseModel with token on success', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
          {
            "isSuccess": true,
            "data": {
              "token": "test-token",
              "expiration": "2025-05-24T12:00:00Z",
              "user": {
                "id": "1",
                "email": "test@example.com",
                "firstName": "John",
                "lastName": "Doe"
              }
            }
          }
        ''');
        when(() => httpClient.post(any(), body: any(named: 'body')))
            .thenAnswer((_) async => response);

        final actual = await apiClient.loginUser(loginData);

        expect(actual.isSuccess, true);
        expect(actual.data, isNotNull);
        expect(actual.data!.token, 'test-token');
        expect(actual.data!.user.email, 'test@example.com');
      });

      test('returns LoginResponseModel with error on failure', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(401);
        when(() => response.body)
            .thenReturn('{"isSuccess": false, "error": "Invalid credentials"}');
        when(() => httpClient.post(any(), body: any(named: 'body')))
            .thenAnswer((_) async => response);

        final actual = await apiClient.loginUser(loginData);

        expect(actual.isSuccess, false);
        expect(actual.data, isNull);
        expect(actual.error, 'Invalid credentials');
      });
    });

    group('getUser', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"isSuccess": true}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        try {
          await apiClient.getUser();
        } catch (_) {}

        verify(
          () => httpClient.get(
            Uri.http(Constants.authority, 'api/users/me'),
          ),
        ).called(1);
      });

      test('returns UserModel on success', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
          {
            "isSuccess": true,
            "data": {
              "id": "1",
              "email": "test@example.com",
              "firstName": "John",
              "lastName": "Doe"
            }
          }
        ''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        final actual = await apiClient.getUser();

        expect(actual, isA<UserModel>());
        expect(actual.id, '1');
        expect(actual.email, 'test@example.com');
      });

      test('throws exception when user data is not found', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body)
            .thenReturn('{"isSuccess": false, "error": "User not found"}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        expect(
          () => apiClient.getUser(),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('updateUser', () {
      final updateData = UserModel(
        firstName: 'Updated',
        lastName: 'Name',
      );

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"isSuccess": true}');
        when(() => httpClient.put(any(), body: any(named: 'body')))
            .thenAnswer((_) async => response);

        try {
          await apiClient.updateUser(updateData);
        } catch (_) {}

        verify(
          () => httpClient.put(
            Uri.http(Constants.authority, 'api/users/profile'),
            body: updateData.toJson(),
          ),
        ).called(1);
      });

      test('returns updated UserModel on success', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
          {
            "isSuccess": true,
            "data": {
              "id": "1",
              "firstName": "Updated",
              "lastName": "Name",
              "email": "test@example.com"
            }
          }
        ''');
        when(() => httpClient.put(any(), body: any(named: 'body')))
            .thenAnswer((_) async => response);

        final actual = await apiClient.updateUser(updateData);

        expect(actual, isA<UserModel>());
        expect(actual.firstName, 'Updated');
        expect(actual.lastName, 'Name');
      });

      test('throws exception on update failure', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body)
            .thenReturn('{"isSuccess": false, "error": "Invalid data"}');
        when(() => httpClient.put(any(), body: any(named: 'body')))
            .thenAnswer((_) async => response);

        expect(
          () => apiClient.updateUser(updateData),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
