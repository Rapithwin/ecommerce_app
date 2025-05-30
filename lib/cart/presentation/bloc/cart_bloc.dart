import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce/cart/presentation/models/cart_model.dart';
import 'package:e_commerce_data/cart_data/cart_api_client.dart';
import 'package:e_commerce_data/cart_data/models/cart.dart';
import 'package:e_commerce_repository/cart_repository/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository = CartRepository();

  CartBloc() : super(CartInitial()) {
    on<LoadCart>(_onLoad);
    on<AddItemToCart>(_onAddItem);
    on<RemoveItemFromCart>(_onRemoveItem());
  }
  FutureOr<void> _onLoad(event, emit) async {
    emit(CartLoading());
    try {
      final cartData = await _cartRepository.getCart(event.token);
      if (cartData.data != null && cartData.data!.items != null) {
        emit(CartLoaded(items: cartData.data!.items!));
      }
    } on CartEmptyFailure {
      emit(const CartError("cart-empty"));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  FutureOr<void> _onAddItem(event, emit) async {
    emit(CartLoading());
    try {
      final updatedCart = await _cartRepository.addToCart(
        productId: event.productId,
        quantity: event.quantity,
        token: event.token,
      );
      emit(
        CartLoaded(
          items: updatedCart.data!.items!,
        ),
      );
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _cartRepository.dispose();
    return super.close();
  }
}
