part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class AddItemToCart extends CartEvent {
  final Cart item;

  const AddItemToCart(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveItemFromCart extends CartEvent {}
