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
      bottomNavigationBar: NavigationBar(
        height: 58,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: selectedTab.index,
        onDestinationSelected: (int index) =>
            context.read<RootCubit>().setTab(index.toTab),
        // indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStatePropertyAll(
          theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Image.asset(
              "assets/images/bottom_navbar/shop-filled.png",
              color: theme.colorScheme.secondary,
              height: 34,
              width: 34,
            ),
            icon: Image.asset(
              "assets/images/bottom_navbar/shop-outlined.png",
              color: theme.colorScheme.secondary,
              height: 34,
              width: 34,
            ),
            label: 'خانه',
          ),
          NavigationDestination(
            selectedIcon: Image.asset(
              "assets/images/icons/heart-filled.png",
              color: theme.colorScheme.secondary,
              height: 34,
              width: 34,
            ),
            icon: Image.asset(
              "assets/images/icons/heart-outlined.png",
              color: theme.colorScheme.secondary,
              height: 34,
              width: 34,
            ),
            label: 'علاقه‌مندی‌ها',
          ),
          NavigationDestination(
            selectedIcon: Image.asset(
              "assets/images/bottom_navbar/cart-filled.png",
              color: theme.colorScheme.secondary,
              height: 34,
              width: 34,
            ),
            icon: Image.asset(
              "assets/images/bottom_navbar/cart-outlined.png",
              color: theme.colorScheme.secondary,
              height: 34,
              width: 34,
            ),
            label: 'سبد خرید',
          ),
          NavigationDestination(
            selectedIcon: Image.asset(
              "assets/images/bottom_navbar/person-filled.png",
              color: theme.colorScheme.secondary,
              height: 34,
              width: 34,
            ),
            icon: Image.asset(
              "assets/images/bottom_navbar/person-outlined.png",
              color: theme.colorScheme.secondary,
              height: 34,
              width: 34,
            ),
            label: 'پروفایل',
          ),
        ],
      ),
    );
  }
}

extension on int {
  RootTab get toTab {
    switch (this) {
      case 0:
        return RootTab.home;
      case 1:
        return RootTab.favorites;
      case 2:
        return RootTab.cart;
      case 3:
        return RootTab.profile;
      default:
        return RootTab.home;
    }
  }
}
