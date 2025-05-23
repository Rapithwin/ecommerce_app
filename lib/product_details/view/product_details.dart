import 'package:e_commerce/product_details/widgets/widgets.dart';
import 'package:e_commerce/products/presentation/cubit/products_cubit.dart';
import 'package:e_commerce_data/products_data/models/product.dart';
import 'package:e_commerce_repository/products_repository/products_repostitory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.id});

  final int id;

  static Route<ProductDetails> route(int id) {
    return MaterialPageRoute(
      builder: (_) => ProductDetails(
        id: id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = ProductsCubit(context.read<ProductsRepostitory>());
        cubit.fetchProductsById(id: id);
        return cubit;
      },
      child: ProductDetailsView(),
    );
  }
}

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          return switch (state.status) {
            ProductsStatus.initial => const DetailsLoading(),
            ProductsStatus.loading => const DetailsLoading(),
            ProductsStatus.failure => const DetailsFailure(),
            ProductsStatus.success => DetailsSuccess(product: state.products),
          };
        },
      ),
    );
  }
}
