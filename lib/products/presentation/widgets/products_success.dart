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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
        ),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.image,
                  size: 120,
                ),
                Expanded(
                  child: SizedBox(
                    width: 180,
                    child: Center(
                      child: Text(
                        products[index].name,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    products[index].price.toString(),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
