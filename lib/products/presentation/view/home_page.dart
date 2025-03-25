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
      create: (context) => ProductsCubit(
        context.read<ProductsRepostitory>(),
      ),
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    context.read<ProductsCubit>().fetchProducts();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height / 6,
        actions: AppBarWidgets.appBarActions(size, theme),
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          return switch (state.status) {
            ProductsStatus.initial => const ProductsLoading(),
            ProductsStatus.loading => const ProductsLoading(),
            ProductsStatus.failure => const ProductsFailure(),
            ProductsStatus.success => ProductsSuccess(products: state.products),
          };
        },
      ),
    );
  }
}
