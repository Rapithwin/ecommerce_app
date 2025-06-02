part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final CartData cartData;
  final String? loadingItemId;

  const CartLoaded({required this.cartData, this.loadingItemId});

  @override
  List<Object?> get props => [cartData, loadingItemId];
}

final class ItemAddSuccess extends CartState {}

final class ItemAddInitial extends CartState {}

final class ItemRemoveSuccess extends CartState {}

final class ItemRemoveInitial extends CartState {}

final class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}
