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
    final theme = Theme.of(context);
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
              icon: Image.asset(
                "assets/images/bottom_navbar/shop-outlined.png",
                color: theme.colorScheme.secondary,
              ),
              selectedIcon: Image.asset(
                "assets/images/bottom_navbar/shop-filled.png",
                color: theme.colorScheme.secondary,
              ),
            ),
            _RootTabButton(
              groupValue: selectedTab,
              value: RootTab.catalog,
              icon: Image.asset(
                "assets/images/icons/heart-outlined.png",
                color: theme.colorScheme.secondary,
              ),
              selectedIcon: Image.asset(
                "assets/images/icons/heart-filled.png",
                color: theme.colorScheme.secondary,
              ),
            ),
            _RootTabButton(
              groupValue: selectedTab,
              value: RootTab.cart,
              icon: Image.asset(
                "assets/images/bottom_navbar/cart-outlined.png",
                color: theme.colorScheme.secondary,
              ),
              selectedIcon: Image.asset(
                "assets/images/bottom_navbar/cart-filled.png",
                color: theme.colorScheme.secondary,
              ),
            ),
            _RootTabButton(
              groupValue: selectedTab,
              value: RootTab.profile,
              icon: Image.asset(
                "assets/images/bottom_navbar/person-outlined.png",
                color: theme.colorScheme.secondary,
              ),
              selectedIcon: Image.asset(
                "assets/images/bottom_navbar/person-filled.png",
                color: theme.colorScheme.secondary,
              ),
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
    required this.selectedIcon,
  });

  final RootTab groupValue;
  final RootTab value;
  final Widget icon;
  final Widget selectedIcon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<RootCubit>().setTab(value),
      iconSize: 32,
      color:
          groupValue != value ? null : Theme.of(context).colorScheme.secondary,
      icon: icon,
      isSelected: value == groupValue,
      selectedIcon: selectedIcon,
    );
  }
}
