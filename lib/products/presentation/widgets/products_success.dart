import 'package:e_commerce/products/presentation/view/product_details.dart';
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
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.push(
                context,
                ProductDetails.route(products[index]),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
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
                  Expanded(
                    flex: 7,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(7),
                        ),
                      ),
                      child: Icon(
                        Icons.image,
                        size: 120,
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 0.5,
                    color: theme.colorScheme.outlineVariant,
                  ),
                  Flexible(
                    flex: 2,
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
                  Flexible(
                    flex: 1,
                    child: Text(
                      products[index].price.toString(),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
