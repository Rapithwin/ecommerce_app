import 'package:e_commerce_data/products_data/models/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductData.fromJson', () {
    test('parses JSON correctly', () {
      final json = {
        "id": 1,
        "name": "Test Product",
        "description": "A test product",
        "price": 100,
        "stockQuantity": 5
      };

      final productData = ProductData.fromJson(json);

      expect(productData.id, 1);
      expect(productData.name, "Test Product");
      expect(productData.description, "A test product");
      expect(productData.price, 100);
      expect(productData.stockQuantity, 5);
    });
  });

  group('Product.fromJson', () {
    test('parses JSON with data list correctly', () {
      final json = {
        "data": [
          {
            "id": 1,
            "name": "Test Product",
            "description": "A test product",
            "price": 100,
            "stockQuantity": 5
          }
        ],
        "error": null
      };

      final product = Product.fromJson(json);

      expect(product.data!.length, 1);
      expect(product.data!.first.name, "Test Product");
      expect(product.error, null);
    });
  });
}
