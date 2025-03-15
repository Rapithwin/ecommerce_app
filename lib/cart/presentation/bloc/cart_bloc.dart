import 'package:bloc/bloc.dart';
import 'package:e_commerce/cart/presentation/models/cart_model.dart';
import 'package:e_commerce_data/cart_data/models/cart.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
