import 'package:e_commerce_data/products_data/models/product.dart';
import 'package:equatable/equatable.dart';

enum ProductStatus { initial, loading, success, failure }

extension ProductStatusX on ProductStatus {
  bool get isInitial => this == ProductStatus.initial;
  bool get isLoading => this == ProductStatus.loading;
  bool get isSuccess => this == ProductStatus.success;
  bool get isFailure => this == ProductStatus.failure;
}

final class ProductsState extends Equatable {
  final ProductStatus status;
  final List<Product> product;

  ProductsState({this.status = ProductStatus.initial, List<Product>? product})
      : product = product ?? [];

  @override
  List<Object?> get props => [status, product];
}
