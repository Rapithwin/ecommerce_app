import 'package:e_commerce_data/data_constants.dart';
import 'package:e_commerce_data/products_data/models/product.dart';
import 'package:e_commerce_data/products_data/product_api_client.dart';
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
              Constants.authority,
              "api/products",
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
        when(() => response.body).thenReturn('{"data": []}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.getAllProducts(),
          throwsA(isA<ProductsEmptyFailure>()),
        );
      });

      test("Returns products on valid response", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
  {
    "data": [
      {
        "id": 1,
        "name": "test",
        "description": "this is a test.",
        "price": 1,
        "stockQuantity": 10
      }
    ],
    "error": null
  }
  ''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.getAllProducts();

        expect(actual.data, isNotNull);
        expect(actual.data, isA<List<ProductData>>());
        expect(actual.data!.length, 1);

        final product = actual.data!.first;
        expect(product.id, 1);
        expect(product.name, "test");
        expect(product.description, "this is a test.");
        expect(product.price, 1);
        expect(product.stockQuantity, 10);
      });
    });

    group("getProductById", () {
      const int id = 1;
      test("Makes correct http request.", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.getProductById(id: id);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.http(
              Constants.authority,
              "api/products/$id",
            ),
          ),
        ).called(1);
      });

      test("Throws ProductNotFoundFailure on error", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"data": null}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.getProductById(id: id),
          throwsA(isA<ProductNotFoundFailure>()),
        );
      });

      test("Returns products on valid response", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
     {"data": {
      "id": 1,
      "name": "test",
      "description": "this is a test.",
      "price": 1,
      "stockQuantity": 10
    }}
  ''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.getProductById(id: id);

        expect(actual.data, isNotNull);
        expect(actual.data, isA<List<ProductData>>());
        expect(actual.data!.length, 1);

        final product = actual.data!.first;
        expect(product.id, 1);
        expect(product.name, "test");
        expect(product.description, "this is a test.");
        expect(product.price, 1);
        expect(product.stockQuantity, 10);
      });
    });
  });
}
