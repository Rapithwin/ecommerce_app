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
        padding: EdgeInsets.symmetric(horizontal: 13),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: theme.colorScheme.outline,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
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
