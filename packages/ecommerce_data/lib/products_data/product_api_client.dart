import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data_constants.dart';
import 'models/product.dart';

/// Exception thrown when products list is empty.
class ProductsEmptyFailure implements Exception {}

/// Exception thrown when getAllProducts fails.
class ProductsRequestFailure implements Exception {}

/// {@template product_api_client}
/// Dart API Client which wraps the e-commerce API for the products endpoint.
/// {@endtemplate}
class ProductApiClient {
  /// {@macro product_api_client}
  ProductApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  static const _productsEndpoint = "api/Products";

  /// Fetches all of the products and returns a list of them.
  Future<List<Product>> getAllProducts() async {
    final productsRequest = Uri.http(Constants.baseUrlStore, _productsEndpoint);

    final productResponse = await _httpClient.get(productsRequest);

    if (productResponse.statusCode != 200) {
      throw ProductsRequestFailure();
    }

    final products = jsonDecode(productResponse.body) as List;

    // Iterates through each element in products list and converts the json
    // elements to a Map<String, dynamic>
    final result = products.map((e) => Product.fromJson(e)).toList();

    if (result.isEmpty) throw ProductsEmptyFailure();

    return result;
  }
}
