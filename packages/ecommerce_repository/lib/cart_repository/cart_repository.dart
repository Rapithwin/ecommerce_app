import 'package:e_commerce_data/cart_data/cart_api_client.dart';
import 'package:e_commerce_data/cart_data/models/cart.dart';

/// {@template cart_repository}
/// A repository that handles `Cart` related requests.
/// {@endtemplate}
class CartRepository {
  final CartApiClient _cartApi;

  /// {@macro cart_repository}
  CartRepository({CartApiClient? cartApi})
      : _cartApi = cartApi ?? CartApiClient();

  /// Provides an instanse of [Cart] which includes the cart
  /// items.
  Future<Cart> getCart({required String userId}) =>
      _cartApi.getCart(userId: userId);

  /// Handles adding items to the cart and returns an
  /// instance of [Cart].
  Future<Cart> addToCart({required Cart query}) =>
      _cartApi.addToCart(query: query);

  void dispose() => _cartApi.close();
}
