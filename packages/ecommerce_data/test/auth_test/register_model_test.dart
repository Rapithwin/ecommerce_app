import 'package:e_commerce_data/auth_data/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('RegisterResponseModel', () {
    test('fromJson should correctly parse successful response', () {
      final json = {
        'isSuccess': true,
        'error': null,
      };

      final result = RegisterResponseModel.fromJson(json);

      expect(result.isSuccess, true);
      expect(result.error, null);
    });

    test('fromJson should correctly parse error response', () {
      final json = {
        'isSuccess': false,
        'error': 'Invalid credentials',
      };

      final result = RegisterResponseModel.fromJson(json);

      expect(result.isSuccess, false);
      expect(result.error, 'Invalid credentials');
    });

    test('fromJson should handle missing error field', () {
      final json = {
        'isSuccess': true,
      };

      final result = RegisterResponseModel.fromJson(json);

      expect(result.isSuccess, true);
      expect(result.error, null);
    });
  });
}
