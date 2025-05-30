part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {
  final String token;

  const LoadCart(this.token);

  @override
  List<Object> get props => [token];
}

class AddItemToCart extends CartEvent {
  final int productId;
  final int quantity;
  final String token;

  const AddItemToCart(
    this.productId,
    this.quantity,
    this.token,
  );

  @override
  List<Object> get props => [productId, quantity, token];
}

class RemoveItemFromCart extends CartEvent {
  final int itemId;
  final String token;

  const RemoveItemFromCart(this.itemId, this.token);

  @override
  List<Object> get props => [itemId, token];
}
