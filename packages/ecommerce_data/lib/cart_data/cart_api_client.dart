import 'dart:convert';

import 'package:e_commerce_data/cart_data/models/cart.dart';
import 'package:e_commerce_data/data_constants.dart';
import 'package:http/http.dart' as http;

/// Exception thrown when cart list is empty.
class CartEmptyFailure implements Exception {}

/// Exception thrown when getCart fails.
class CartRequestFailure implements Exception {}

class CartApiClient {
  CartApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  final http.Client _httpClient;

  final _cartEndpoint = "api/Carts";

  Future<Cart> getCart({required String userId}) async {
    final cartRequest =
        Uri.http(Constants.baseUrlStore, "$_cartEndpoint/$userId");

    final cartResponse = await _httpClient.get(cartRequest);

    if (cartResponse.statusCode != 200) throw CartRequestFailure();

    final cartJson = jsonDecode(cartResponse.body);

    final result = Cart.fromJson(cartJson);

    if (result.cartItems.isEmpty) throw CartEmptyFailure();

    return result;
  }
}
