import 'package:e_commerce/cart/presentation/view/cart_page.dart';
import 'package:e_commerce/profile/presentation/view/profile_page.dart';
import 'package:e_commerce/root/cubit/root_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce/products/presentation/view/view.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  static Route<RootPage> route() {
    return MaterialPageRoute(
      builder: (_) => const RootPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RootCubit(),
      child: RootView(),
    );
  }
}

class RootView extends StatelessWidget {
  RootView({super.key});
  final List<Widget> _pages = [
    const HomePage(),
    const CatalogPage(),
    const CartPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((RootCubit cubit) => cubit.state.tab);
    final theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
        body: size.width < 800
            ? IndexedStack(
                index: selectedTab.index,
                children: const <Widget>[
                  HomePage(),
                  CatalogPage(),
                  CartPage(),
                  ProfilePage(),
                ],
              )
            : Row(
                children: [
                  NavigationRail(
                    labelType: NavigationRailLabelType.selected,
                    destinations: navigationRailDestinations(theme),
                    selectedIndex: selectedTab.index,
                    onDestinationSelected: (int index) =>
                        context.read<RootCubit>().setTab(index.toTab),
                  ),
                  VerticalDivider(
                    color: theme.colorScheme.outlineVariant,
                  ),
                  Expanded(
                    child: _pages[selectedTab.index],
                  ),
                ],
              ),
        bottomNavigationBar: size.width < 800
            ? NavigationBar(
                height: 58,
                labelBehavior:
                    NavigationDestinationLabelBehavior.onlyShowSelected,
                selectedIndex: selectedTab.index,
                onDestinationSelected: (int index) =>
                    context.read<RootCubit>().setTab(index.toTab),
                // indicatorColor: Colors.transparent,
                labelTextStyle: WidgetStatePropertyAll(
                  theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                destinations: navigationDestinations(theme),
              )
            : null);
  }

  List<NavigationDestination> navigationDestinations(ThemeData theme) {
    return <NavigationDestination>[
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
    ];
  }

  List<NavigationRailDestination> navigationRailDestinations(ThemeData theme) {
    return <NavigationRailDestination>[
      NavigationRailDestination(
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
        label: const Text('خانه'),
      ),
      NavigationRailDestination(
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
        label: const Text('علاقه‌مندی‌ها'),
      ),
      NavigationRailDestination(
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
        label: const Text('سبد خرید'),
      ),
      NavigationRailDestination(
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
        label: const Text('پروفایل'),
      ),
    ];
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
