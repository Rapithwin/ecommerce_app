import 'dart:async';

import 'package:e_commerce/products/presentation/cubit/products_cubit.dart';
import 'package:e_commerce/products/presentation/widgets/widgets.dart';
import 'package:e_commerce_repository/products_repository/products_repostitory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = ProductsCubit(context.read<ProductsRepostitory>());
        cubit.fetchProducts(page: 1);
        return cubit;
      },
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _sreachBarController = SearchController();
  Timer? _debounce;

  @override
  void dispose() {
    _sreachBarController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () {
      context.read<ProductsCubit>().fetchProducts(
            serachEntry: value,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        actions: AppBarWidgets.appBarActions(size, theme),
        backgroundColor: theme.colorScheme.surfaceContainerLow,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
            child: SizedBox(
              height: size.height / 18,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SearchBar(
                  controller: _sreachBarController,
                  onChanged: _onSearchChanged,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  backgroundColor: WidgetStatePropertyAll(
                      theme.colorScheme.surfaceContainerHighest),
                  shadowColor: const WidgetStatePropertyAll(Colors.transparent),
                  leading: IconButton(
                    onPressed: () {
                      context.read<ProductsCubit>().fetchProducts(
                            serachEntry: _sreachBarController.text,
                          );
                    },
                    icon: const Icon(Icons.search),
                    splashRadius: 1,
                  ),
                  hintText: "جستجو...",
                  hintStyle: WidgetStatePropertyAll(
                    theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => context.read<ProductsCubit>().fetchProducts(),
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  return switch (state.status) {
                    ProductsStatus.initial => const ProductsLoading(),
                    ProductsStatus.loading => const ProductsLoading(),
                    ProductsStatus.failure => const ProductsFailure(),
                    ProductsStatus.success => ProductsSuccess(
                        products: state.products,
                      ),
                  };
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
