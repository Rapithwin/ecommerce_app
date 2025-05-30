import 'package:bloc/bloc.dart';
import 'package:e_commerce/cart/presentation/models/cart_model.dart';
import 'package:e_commerce_data/cart_data/models/cart.dart';
import 'package:e_commerce_repository/cart_repository/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository = CartRepository();

  CartBloc() : super(CartInitial()) {
    on<LoadCart>(_onLoad());
    on<ClearCart>(_onClear());
    on<AddItemToCart>(_onAddItem());
    on<RemoveItemFromCart>(_onRemoveItem());
  }
  @override
  Future<void> close() {
    _cartRepository.dispose();
    return super.close();
  }
}
