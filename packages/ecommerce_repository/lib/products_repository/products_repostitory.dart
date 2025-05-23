import 'package:e_commerce_data/products_data/models/product.dart';
import 'package:e_commerce_data/products_data/product_api_client.dart';

/// {@template products_repository}
/// A repository that handles `Product` related requests.
/// {@endtemplate}
class ProductsRepostitory {
  /// {@macro products_repository}
  ProductsRepostitory({ProductApiClient? productApi})
      : _productApi = productApi ?? ProductApiClient();
  final ProductApiClient _productApi;

  /// Provides a [List] of all the available products.
  Future<Product> getProducts() => _productApi.getAllProducts();

  /// Provides a product of a given `id`.
  Future<Product> getProductById({required int id}) =>
      _productApi.getProductById(id: id);

  /// Disposes any resources managed by the repository.
  void dispose() => _productApi.close();
}
