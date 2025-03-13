import 'package:e_commerce_data/cart_data/cart_api_client.dart';
import 'package:e_commerce_data/cart_data/models/cart.dart';
import 'package:e_commerce_data/data_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client httpClient;
  late CartApiClient apiClient;

  group("CartApiClient", () {
    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = CartApiClient(httpClient: httpClient);
    });

    group("constructor", () {
      test("Does not require an httpClient", () {
        expect(CartApiClient(), isNotNull);
      });
    });

    group("getCart", () {
      test("Makes correct http request.", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn("{}");
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.getCart(userId: "1");
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.http(
              Constants.baseUrlStore,
              "api/Carts/1",
            ),
          ),
        ).called(1);
      });

      test("Throws CartRequestFailure on non 200 response", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.getCart(userId: "1"),
          throwsA(isA<CartRequestFailure>()),
        );
      });

      test("Throws CartEmptyFailure on empty list response", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
  {
    "id": 1,
    "userId": "…",
    "cartItems": []
  }
''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.getCart(userId: "1"),
          throwsA(isA<CartEmptyFailure>()),
        );
      });

      test("Returns cart on valid response", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
{
  "id": 1,
  "userId": "1",
  "cartItems": [
    {
      "id": 1,
      "productId": 1,
      "productName": "test",
      "quantity": 1
    }
  ]
}
''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.getCart(userId: "1");
        final matcher = isA<Cart>()
            .having((e) => e.id, "id", 1)
            .having((e) => e.userId, "userId", "1")
            .having(
              (e) => e.cartItems,
              "cartItems",
              isA<List<CartItems>>()
                  .having((e) => e[0].id, "id", 1)
                  .having((e) => e[0].productId, "productId", 1)
                  .having((e) => e[0].productName, "productName", "test")
                  .having((e) => e[0].quantity, "quantity", 1),
            );
        expect(actual, matcher);
      });
    });
  });
}
