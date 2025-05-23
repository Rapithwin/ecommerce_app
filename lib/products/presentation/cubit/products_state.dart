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
  final bool isLoadingMore;

  const ProductsState({
    this.status = ProductsStatus.initial,
    required this.products,
    this.isLoadingMore = false,
  });

  ProductsState copyWith(
      {ProductsStatus? status, Product? products, bool? isLoadingMore}) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        isLoadingMore,
      ];
}
