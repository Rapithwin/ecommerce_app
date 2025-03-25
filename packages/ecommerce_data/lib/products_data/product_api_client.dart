import 'dart:convert';

import 'package:dart_style/src/debug.dart';
import 'package:http/http.dart' as http;

import '../data_constants.dart';
import 'models/product.dart';

/// Exception thrown when products list is empty.
class ProductsEmptyFailure implements Exception {}

/// Exception thrown when getAllProducts or getProductById fails.
class ProductsRequestFailure implements Exception {}

/// Exception thrown when a product is not found.
class ProductNotFoundFailure implements Exception {}

/// {@template product_api_client}
/// Dart API Client which wraps the e-commerce API for the products endpoint.
/// {@endtemplate}
class ProductApiClient {
  /// {@macro product_api_client}
  ProductApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  final _productsEndpoint = "api/Products";

  /// Fetches all of the products and returns a list of them.
  Future<List<Product>> getAllProducts() async {
    try {
      final productsRequest = Uri.http(
        Constants.authority,
        '$_productsEndpoint',
      );

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
    } catch (error, stacktrace) {
      log("Error during api call $error");
      log("Stacktrace $stacktrace");
      rethrow;
    }
  }

  /// Fetches the product of the given id.
  Future<Product> getProductById({required int id}) async {
    final productRequest =
        Uri.http(Constants.authority, "$_productsEndpoint/$id");

    final productResponse = await _httpClient.get(productRequest);

    if (productResponse.statusCode != 200) {
      throw ProductsRequestFailure();
    }

    final productJson =
        jsonDecode(productResponse.body) as Map<String, dynamic>;

    if (!productJson.containsKey("id")) {
      throw ProductNotFoundFailure();
    }

    final result = Product.fromJson(productJson);

    return result;
  }

  /// Closes the underlying http client.
  void close() => _httpClient.close();
}
