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
  Future<Cart> getCart(token) async => await _cartApi.getCart(token);

  /// Handles adding items to the cart and returns an
  /// instance of [Cart].
  Future<Cart> addToCart(
          {required int productId,
          required int quantity,
          required String token}) async =>
      await _cartApi.addToCart(
        productId: productId,
        quantity: quantity,
        token: token,
      );

  Future<Cart> deleteItemFromCart({
    required int itemId,
    required String token,
  }) async =>
      await _cartApi.deleteItemFromCart(
        itemId: itemId,
        token: token,
      );

  void dispose() => _cartApi.close();
}
