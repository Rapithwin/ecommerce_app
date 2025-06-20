import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_data/cart_data/cart_api_client.dart';
import 'package:e_commerce_data/cart_data/models/cart.dart';
import 'package:e_commerce_repository/cart_repository/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;

  CartBloc(this._cartRepository) : super(CartInitial()) {
    on<LoadCart>(_onLoad);
    on<AddItemToCart>(_onAddItem);
    on<RemoveItemFromCart>(_onRemoveItem);
  }
  FutureOr<void> _onLoad(event, emit) async {
    emit(CartLoading());
    try {
      final cartData = await _cartRepository.getCart(event.token);
      if (cartData.data != null) {
        emit(CartLoaded(cartData: cartData.data!));
      }
    } on CartEmptyFailure {
      emit(const CartError("cart-empty"));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  FutureOr<void> _onAddItem(event, emit) async {
    emit(ItemAddInitial());
    try {
      final updatedCart = await _cartRepository.addToCart(
        productId: event.productId,
        quantity: event.quantity,
        token: event.token,
      );
      emit(CartLoaded(cartData: updatedCart.data!));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  FutureOr<void> _onRemoveItem(event, emit) async {
    emit(ItemRemoveInitial());
    try {
      await _cartRepository.deleteItemFromCart(
        itemId: event.itemId,
        token: event.token,
      );
      final cartData = await _cartRepository.getCart(event.token);
      if (cartData.data != null) {
        emit(CartLoaded(cartData: cartData.data!));
      }
    } on CartEmptyFailure {
      emit(const CartError("cart-empty"));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
