import 'package:bloc/bloc.dart';
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

  Future<void> fetchProducts({String? serachEntry, required int page}) async {
    emit(state.copyWith(status: ProductsStatus.loading));

    try {
      final products = await _productsRepostitory.getProducts(
          serachEntry: serachEntry, page: page);
      emit(state.copyWith(
        status: ProductsStatus.success,
        products: products,
      ));
    } on Exception {
      emit(state.copyWith(status: ProductsStatus.failure));
    }
  }

  Future<void> fetchProductsById({required int id}) async {
    emit(state.copyWith(status: ProductsStatus.loading));

    try {
      final product = await _productsRepostitory.getProductById(id: id);
      emit(state.copyWith(
        status: ProductsStatus.success,
        products: product,
      ));
    } on Exception {
      emit(state.copyWith(status: ProductsStatus.failure));
    }
  }
}
