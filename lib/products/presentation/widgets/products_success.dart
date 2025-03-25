import 'package:e_commerce_data/products_data/models/product.dart';
import 'package:flutter/material.dart';

class ProductsSuccess extends StatelessWidget {
  const ProductsSuccess({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Text(
                products[index].name,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Text(
                products[index].price.toString(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
