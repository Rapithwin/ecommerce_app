import 'package:e_commerce_data/products_data/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final Product product;

  static Route<ProductDetails> route(Product product) {
    return MaterialPageRoute(
      builder: (_) => ProductDetails(
        product: product,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite),
              iconSize: 30,
            ),
          )
        ],
      ),
      body: Center(
        child: Text(product.name),
      ),
    );
  }
}
