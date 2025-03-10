import 'package:e_commerce/cart/presentation/view/cart_page.dart';
import 'package:e_commerce/profile/presentation/view/profile_page.dart';
import 'package:e_commerce/root/cubit/root_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce/products/presentation/view/view.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RootCubit(),
      child: const RootView(),
    );
  }
}

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((RootCubit cubit) => cubit.state.tab);
    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: <Widget>[
          HomePage(),
          CatalogPage(),
          CartPage(),
          ProfilePage()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _RootTabButton(
              groupValue: selectedTab,
              value: RootTab.home,
              icon: Icon(Icons.home),
            ),
            _RootTabButton(
              groupValue: selectedTab,
              value: RootTab.catalog,
              icon: Icon(Icons.book),
            ),
            _RootTabButton(
              groupValue: selectedTab,
              value: RootTab.cart,
              icon: Icon(Icons.shopping_cart_sharp),
            ),
            _RootTabButton(
              groupValue: selectedTab,
              value: RootTab.profile,
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}

class _RootTabButton extends StatelessWidget {
  const _RootTabButton({
    required this.groupValue,
    required this.value,
    required this.icon,
  });

  final RootTab groupValue;
  final RootTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<RootCubit>().setTab(value),
      iconSize: 32,
      color:
          groupValue != value ? null : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}
