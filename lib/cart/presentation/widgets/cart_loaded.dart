import 'package:e_commerce/cart/presentation/widgets/add_quantity.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CartSuccess extends StatelessWidget {
  const CartSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);

    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: Container(
                height: size.height / 6,
                // width: size.width,

                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHigh,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  border: Border.all(
                    color: theme.colorScheme.outline,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            " تتسیبنشیبت یشس بشینبت ش شیمحصول فلایبلسیبل سیبل سب لسیب لسیبل سیبل سیبل بیشبسشسیبسیبشسیبشین",
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              AddQuantity(
                                minNumber: 0,
                                maxNumber: 20,
                                iconSize: 017,
                                value: 2,
                                valueChanged: (quantity) {},
                              ),
                              Text(
                                "${"13000000".seRagham().toPersianDigit()} تومان",
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image(
                          image: NetworkImage(
                              "https://static.owayo-cdn.com/newhp/img/productHome/productSeitenansicht/productservice/tshirts_classic_herren_basic_productservice/st2020_gyh.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
