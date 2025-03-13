import 'package:e_commerce_data/cart_data/models/cart.dart';

import 'package:test/test.dart';

void main() {
  group("Product", () {
    group("fromJson", () {
      test("returns correct Cart object.", () {
        expect(
          Cart.fromJson(<String, dynamic>{
            "id": 1,
            "userId": "1",
            "cartItems": [
              {
                "id": 1,
                "productId": 1,
                "productName": "test",
                "quantity": 1,
              }
            ]
          }),
          isA<Cart>()
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
              ),
        );
      });
    });
  });
}
