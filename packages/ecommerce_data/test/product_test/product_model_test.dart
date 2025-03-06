import 'package:e_commerce_data/products_data/models/product.dart';
import 'package:test/test.dart';

void main() {
  group("Product", () {
    group("fromJson", () {
      test("returns correct Product object.", () {
        expect(
          Product.fromJson(<String, dynamic>{
            "id": 1,
            "name": "test",
            "description": "this is a test.",
            "price": 1
          }),
          isA<Product>()
              .having((e) => e.id, "id", 1)
              .having((e) => e.name, "name", "test")
              .having((e) => e.description, "description", "this is a test.")
              .having((e) => e.price, "price", 1),
        );
      });
    });
  });
}
