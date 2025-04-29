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
          ),
        )
      ],
    );
  }
}
