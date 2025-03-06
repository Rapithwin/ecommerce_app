import 'package:e_commerce/data_constants.dart';
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

    group("getAllProducts", () {
      test("Makes correct http request.", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn("{}");
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.getAllProducts();
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.http(
              Constants.baseUrlStore,
              "api/Products",
            ),
          ),
        ).called(1);
      });

      test("Throws ProductsRequestFailure on non 200 response", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.getAllProducts(),
          throwsA(isA<ProductsRequestFailure>()),
        );
      });

      test("Throws ProductsEmptyFailure on empty list response", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn("[]");
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.getAllProducts(),
          throwsA(isA<ProductsEmptyFailure>()),
        );
      });
    });
  });
}
