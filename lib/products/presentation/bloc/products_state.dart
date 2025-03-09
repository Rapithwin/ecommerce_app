import 'package:e_commerce_data/products_data/models/product.dart';
import 'package:equatable/equatable.dart';

enum ProductsStatus { initial, loading, success, failure }

extension ProductsStatusX on ProductsStatus {
  bool get isInitial => this == ProductsStatus.initial;
  bool get isLoading => this == ProductsStatus.loading;
  bool get isSuccess => this == ProductsStatus.success;
  bool get isFailure => this == ProductsStatus.failure;
}

final class ProductsState extends Equatable {
  final ProductsStatus status;
  final List<Product> products;

  ProductsState({
    this.status = ProductsStatus.initial,
    List<Product>? products,
  }) : products = products ?? [];

  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? products,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [status, products];
}
