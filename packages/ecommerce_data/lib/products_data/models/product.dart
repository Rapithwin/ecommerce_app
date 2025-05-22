import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final List<ProductData>? data;
  final String? error;

  Product({
    this.data,
    this.error,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@JsonSerializable()
class ProductData {
  final int id;
  final String name;
  final String description;
  final int price;
  final int stockQuantity;

  ProductData({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) =>
      _$ProductDataFromJson(json);
}
