import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  final bool? isSuccess;
  final CartData? data;
  final String? error;

  const Cart({
    this.isSuccess,
    this.data,
    this.error,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable()
class CartData {
  final int? id;
  final String? userId;
  final List<CartItems>? items;
  final double? totalPrice;

  factory CartData.fromJson(Map<String, dynamic> json) =>
      _$CartDataFromJson(json);

  CartData({
    this.id,
    this.userId,
    this.items,
    this.totalPrice,
  });

  Map<String, dynamic> toJson() => _$CartDataToJson(this);
}

@JsonSerializable()
class CartItems {
  final int? id;
  final int? productId;
  final String? productName;
  final double? unitPrice;
  final int? quantity;
  final double? totalPrice;

  CartItems({
    this.id,
    this.productId,
    this.productName,
    this.unitPrice,
    this.quantity,
    this.totalPrice,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) =>
      _$CartItemsFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemsToJson(this);
}
