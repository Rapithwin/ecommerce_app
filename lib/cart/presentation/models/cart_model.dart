import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int id;
  final int productId;
  final String productName;
  final int quantity;
  // TODO: price

  const CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
  });

  CartItem copyWith({
    int? quantity,
  }) {
    return CartItem(
      id: id,
      productId: productId,
      productName: productName,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        productName,
        quantity,
      ];
}
