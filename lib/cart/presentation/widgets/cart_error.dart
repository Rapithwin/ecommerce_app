import 'package:flutter/material.dart';

class CartErrorPage extends StatelessWidget {
  const CartErrorPage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        message == "cart-empty" ? "سبد خرید خالی است" : message,
        textDirection: TextDirection.rtl,
        style: theme.textTheme.bodyLarge
            ?.copyWith(color: theme.colorScheme.onSurface),
      ),
    );
  }
}
