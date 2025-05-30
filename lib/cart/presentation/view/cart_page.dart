import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce/cart/presentation/widgets/cart_error.dart';
import 'package:e_commerce/cart/presentation/widgets/cart_loaded.dart';
import 'package:e_commerce/cart/presentation/widgets/cart_loading.dart';
import 'package:e_commerce/profile/presentation/widgets/app_bar_widgets.dart';
import 'package:e_commerce/root/cubit/root_cubit.dart';
import 'package:e_commerce_repository/ecommerce_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (context) {
        final cartBloc = CartBloc(context.read<CartRepository>());

        return cartBloc;
      },
      child: BlocListener<RootCubit, RootState>(
        listener: (context, rootState) {
          final authState = context.read<AuthBloc>().state;
          if (authState is Authenticated && rootState.tab == RootTab.cart) {
            context.read<CartBloc>().add(LoadCart(authState.token));
          }
        },
        child: const CartView(),
      ),
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
          switch (state) {
            case CartError():
              return CartErrorPage(
                message: state.message,
              );
            case CartInitial():
              return const CartLoadingPage();
            case CartLoading():
              return const CartLoadingPage();
            case CartLoaded():
              return CartSuccess(
                cartItems: state.items,
              );
            default:
              return CartLoadingPage();
          }
        },
      ),
    );
  }
}
