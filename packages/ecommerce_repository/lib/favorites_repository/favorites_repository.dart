import 'package:e_commerce_data/favorites_data/favorites_api_client.dart';
import 'package:e_commerce_data/favorites_data/models/favorites_model.dart';

class FavoritesRepository {
  final FavoritesApiClient _favoritesApi;

  FavoritesRepository({FavoritesApiClient? favoritesApi})
      : _favoritesApi = favoritesApi ?? FavoritesApiClient();

  Future<FavoritesModel> getFavorites(String token) async =>
      await _favoritesApi.getFavorites(token);

  Future<FavoritesModel> addToFavorites(String token, int productId) async =>
      await _favoritesApi.addToFavorites(token, productId);

  Future<FavoritesModel> removeFavorite(String token, int itemId) async =>
      _favoritesApi.removeFavorite(token, itemId);

  Future<bool> isFavorited(String token, int productId) async =>
      _favoritesApi.isFavorited(token, productId);
}
