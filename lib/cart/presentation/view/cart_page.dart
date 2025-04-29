import 'package:e_commerce/cart/presentation/widgets/widgets.dart';
import 'package:e_commerce/profile/presentation/widgets/app_bar_widgets.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surfaceContainerLow,
        actions: AppBarWidgets.appBarActions(
          size,
          theme,
          context,
          title: "سبد خرید",
        ),
      ),
      body: CartLoaded(),
    );
  }
}
