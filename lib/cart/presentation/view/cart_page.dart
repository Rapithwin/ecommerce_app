import 'package:e_commerce/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce/cart/presentation/widgets/widgets.dart';
import 'package:e_commerce/profile/presentation/widgets/app_bar_widgets.dart';
import 'package:e_commerce_repository/ecommerce_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(
        context.read<CartRepository>(),
      ),
      child: const CartView(),
    );
  }
}

class CartView extends StatelessWidget {
  const CartView({super.key});

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
      body: const CartSuccess(),
    );
  }
}
