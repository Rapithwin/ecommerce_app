import 'package:http/http.dart' as http;

/// {@template product_api_client}
/// Dart API Client which wraps the e-commerce API for the products endpoint.
/// {@endtemplate}
class ProductApiClient {
  /// {@macro product_api_client}
  ProductApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  static const _productsEndpoint = "/Products";
}
