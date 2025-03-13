import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart extends Equatable {
  final int? id;
  final String userId;
  final List<CartItems> cartItems;

  const Cart({
    this.id,
    required this.userId,
    required this.cartItems,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  @override
  List<Object?> get props => [id, userId, cartItems];
}

@JsonSerializable()
class CartItems {
  final int? id;
  final int productId;
  final String? productName;
  final int quantity;

  CartItems({
    this.id,
    required this.productId,
    this.productName,
    required this.quantity,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) =>
      _$CartItemsFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemsToJson(this);
}
