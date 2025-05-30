import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce/cart/presentation/widgets/cart_error.dart';
import 'package:e_commerce/cart/presentation/widgets/cart_loaded.dart';
import 'package:e_commerce/cart/presentation/widgets/cart_loading.dart';
import 'package:e_commerce/profile/presentation/widgets/app_bar_widgets.dart';
import 'package:e_commerce_repository/ecommerce_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (context) {
        final authState = context.watch<AuthBloc>().state;
        final cartBloc = CartBloc(context.read<CartRepository>());
        if (authState is Authenticated) {
          cartBloc.add(LoadCart(authState.token));
        }
        return cartBloc;
      },
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
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return switch (state) {
            CartError() => const CartErrorPage(),
            CartInitial() => const CartLoadingPage(),
            CartLoading() => const CartLoadingPage(),
            CartLoaded() => const CartSuccess(),
          };
        },
      ),
    );
  }
}
