import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  final int id;
  final String userId;
  final CartItems cartItems;

  Cart({
    required this.id,
    required this.userId,
    required this.cartItems,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}

@JsonSerializable()
class CartItems {
  final int id;
  final int productId;
  final String productName;
  final int quantity;

  CartItems({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) =>
      _$CartItemsFromJson(json);
}
