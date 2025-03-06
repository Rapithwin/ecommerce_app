import 'package:e_commerce/products_data/product_api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client httpClient;
  late ProductApiClient apiClient;

  group("ProductApiClient", () {
    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = ProductApiClient(httpClient: httpClient);
    });

    group("constructor", () {
      test("Does not require an httpClient", () {
        expect(ProductApiClient(), isNotNull);
      });
    });

    group("getAllProducts", () {});
  });
}
