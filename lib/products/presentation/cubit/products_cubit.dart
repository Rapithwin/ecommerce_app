import 'package:bloc/bloc.dart';
import 'package:e_commerce_data/products_data/product_api_client.dart';
import 'package:e_commerce_repository/products_repository/products_repostitory.dart';
import 'package:e_commerce_data/products_data/models/product.dart';
import 'package:equatable/equatable.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productsRepostitory)
      : super(ProductsState(
          products: Product(),
        ));
  final ProductsRepostitory _productsRepostitory;

  Future<void> fetchProducts({String? serachEntry, int page = 1}) async {
    if (state.isLoadingMore) return;

    emit(state.copyWith(
      status: page == 1 ? ProductsStatus.loading : ProductsStatus.success,
      isLoadingMore: page > 1,
    ));

    try {
      final products = await _productsRepostitory.getProducts(
        serachEntry: serachEntry,
        page: page,
      );

// Append new products if not the first page
      final allProducts = page == 1
          ? products.data
          : [...?state.products.data, ...?products.data];

      emit(state.copyWith(
        status: ProductsStatus.success,
        products: Product(data: allProducts),
        isLoadingMore: false,
      ));
    } on ProductsEmptyFailure {
      if (page == 1) {
        emit(state.copyWith(
          status: ProductsStatus.success,
          products: Product(data: []),
          isLoadingMore: false,
        ));
      } else {
        emit(state.copyWith(isLoadingMore: false));
      }
    } catch (_) {
      emit(
          state.copyWith(status: ProductsStatus.failure, isLoadingMore: false));
    }
  }

  Future<void> fetchProductsById({required int id}) async {
    emit(state.copyWith(status: ProductsStatus.loading, isLoadingMore: false));

    try {
      final product = await _productsRepostitory.getProductById(id: id);
      emit(state.copyWith(
          status: ProductsStatus.success,
          products: product,
          isLoadingMore: false));
    } on Exception {
      emit(
          state.copyWith(status: ProductsStatus.failure, isLoadingMore: false));
    }
  }
}
