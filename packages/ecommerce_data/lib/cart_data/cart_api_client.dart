import 'dart:convert';
import 'dart:io';

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

  final _cartEndpoint = "api/basket";

  /// Fetches the cart and all the items in it.
  Future<Cart> getCart(String token) async {
    final cartRequest = Uri.http(
      Constants.authority,
      _cartEndpoint,
    );

    final cartResponse = await _httpClient.get(
      cartRequest,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );

    final cartJson = jsonDecode(cartResponse.body);

    if (cartJson['isSuccess'] == true && cartJson['data'] != null) {
      final updateJson = cartJson['data'] as Map<String, dynamic>;
      final result = Cart.fromJson(updateJson);
      final items = result.data?.items ?? [];

      if (items.isEmpty) throw CartEmptyFailure();

      return result;
    }
    throw Exception(cartJson['error'] ?? "Failed to get cart");
  }

  /// Used to create a cart and add items to a cart.
  Future<Cart> addToCart(
      {required int productId,
      required int quantity,
      required String token}) async {
    final cartRequest = Uri.http(
      Constants.authority,
      "$_cartEndpoint/items",
    );

    final cartResponse = await _httpClient.post(
      cartRequest,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: {
        "productId": productId,
        "quantity": quantity,
      },
    );

    final cartJson = jsonDecode(cartResponse.body);

    if (cartJson['isSuccess'] == true && cartJson['data'] != null) {
      final updateJson = cartJson['data'] as Map<String, dynamic>;
      final result = Cart.fromJson(updateJson);
      final items = result.data?.items ?? [];

      if (items.isEmpty) throw CartEmptyFailure();

      return result;
    }
    throw Exception(cartJson['error'] ?? "Failed to add to cart");
  }

  Future<Cart> deleteItemFromCart({
    required int itemId,
    required String token,
  }) async {
    final cartRequest = Uri.http(
      Constants.authority,
      "$_cartEndpoint/items/$itemId",
    );

    final cartResponse = await _httpClient.post(
      cartRequest,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );

    if (cartResponse.statusCode == 204) {
      return Cart(
        isSuccess: true,
      );
    } else {
      final cartJson = jsonDecode(cartResponse.body);
      final result = Cart.fromJson(cartJson);
      throw Exception(result.error ?? "Failed to add remove from cart");
    }
  }

  void close() => _httpClient.close();
}
