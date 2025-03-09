import 'package:bloc/bloc.dart';
import 'package:e_commerce/products/presentation/bloc/products_state.dart';
import 'package:e_commerce_repository/products_repository/products_repostitory.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productsRepostitory) : super(ProductsState());
  final ProductsRepostitory _productsRepostitory;

  Future<void> fetchProducts() async {
    emit(state.copyWith(status: ProductsStatus.loading));

    try {
      final products = await _productsRepostitory.getProducts();
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
        products: [product],
      ));
    } on Exception {
      emit(state.copyWith(status: ProductsStatus.failure));
    }
  }
}
