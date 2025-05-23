part of 'products_cubit.dart';

enum ProductsStatus { initial, loading, success, failure }

extension ProductsStatusX on ProductsStatus {
  bool get isInitial => this == ProductsStatus.initial;
  bool get isLoading => this == ProductsStatus.loading;
  bool get isSuccess => this == ProductsStatus.success;
  bool get isFailure => this == ProductsStatus.failure;
}

final class ProductsState extends Equatable {
  final ProductsStatus status;
  final Product products;

  const ProductsState({
    this.status = ProductsStatus.initial,
    required this.products,
  });

  ProductsState copyWith({
    ProductsStatus? status,
    Product? products,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [status, products];
}
