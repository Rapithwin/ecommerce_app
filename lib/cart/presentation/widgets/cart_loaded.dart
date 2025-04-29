import 'package:e_commerce/cart/presentation/widgets/add_quantity.dart';
import 'package:flutter/material.dart';

class CartLoaded extends StatelessWidget {
  const CartLoaded({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);

    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: size.height / 6,
            width: size.width,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHigh,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              border: Border.all(
                color: theme.colorScheme.outline,
              ),
            ),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AddQuantity(
                        minNumber: 0,
                        maxNumber: 20,
                        iconSize: 17,
                        value: 2,
                        valueChanged: (quantity) {},
                      ),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          overlayColor: WidgetStateProperty.all(
                            theme.colorScheme.outlineVariant,
                          ),
                        ),
                        child: Text(
                          "حذف",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Text(
                        "} تومان",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 30,
                    ),
                  ),
                  Text(
                    "محصول فلان",
                    textDirection: TextDirection.rtl,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image(
                      image: NetworkImage(
                          "https://static.owayo-cdn.com/newhp/img/productHome/productSeitenansicht/productservice/tshirts_classic_herren_basic_productservice/tshirt_basic_4.jpg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
