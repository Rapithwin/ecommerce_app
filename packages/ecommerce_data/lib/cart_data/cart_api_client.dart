import 'dart:convert';

import 'package:e_commerce_data/cart_data/models/cart.dart';
import 'package:e_commerce_data/data_constants.dart';
import 'package:http/http.dart' as http;

/// Exception thrown when cart list is empty.
class CartEmptyFailure implements Exception {}

/// Exception thrown when getCart fails.
class CartRequestFailure implements Exception {}

/// {@template cart_api_client}
/// Dart API Client which wraps the e-commerce API for the cart endpoint.
/// {@endtemplate}
class CartApiClient {
  /// {@macro cart_api_client}
  CartApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  final http.Client _httpClient;

  final _cartEndpoint = "api/Carts";

  /// Fetches the cart and all the items in it.
  Future<Cart> getCart({required String userId}) async {
    final cartRequest = Uri.http(Constants.authority, "$_cartEndpoint/$userId");

    final cartResponse = await _httpClient.get(cartRequest);

    if (cartResponse.statusCode != 200) throw CartRequestFailure();

    final cartJson = jsonDecode(cartResponse.body);

    final result = Cart.fromJson(cartJson);

    if (result.cartItems.isEmpty) throw CartEmptyFailure();

    return result;
  }

  /// Used to create a cart and add items to a cart.
  Future<Cart> addToCart({required Cart query}) async {
    final cartRequest = Uri.http(
      Constants.authority,
      _cartEndpoint,
    );

    final cartResponse = await _httpClient.post(
      cartRequest,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(query.toJson()),
    );

    if (cartResponse.statusCode != 200) throw CartRequestFailure();

    final cartJson = jsonDecode(cartResponse.body);

    final result = Cart.fromJson(cartJson);

    if (result.cartItems.isEmpty) throw CartEmptyFailure();

    return result;
  }

  // TODO: Delete

  void close() => _httpClient.close();
}
