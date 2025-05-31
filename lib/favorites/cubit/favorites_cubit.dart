import 'package:bloc/bloc.dart';
import 'package:e_commerce_data/favorites_data/favorites_api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_data/favorites_data/models/favorites_model.dart';
import 'package:e_commerce_repository/favorites_repository/favorites_repository.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesCubit(this._favoritesRepository)
      : super(FavoritesState(favorites: FavoritesModel()));

  // Fetch all favorites (for favorites page)
  Future<void> fetchFavorites(String token) async {
    emit(state.copyWith(status: FavoritesStatus.loading, error: null));
    try {
      final favorites = await _favoritesRepository.getFavorites(token);
      emit(state.copyWith(
        status: FavoritesStatus.success,
        favorites: favorites,
        error: null,
      ));
    } on FavoritesEmptyFailure {
      emit(state.copyWith(
        status: FavoritesStatus.success,
        favorites: FavoritesModel(data: FavoritesData(items: [], count: 0)),
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesStatus.failure,
        error: e.toString(),
      ));
    }
  }

  // Add to favorites (for product details page)
  Future<void> addToFavorites(String token, int productId) async {
    emit(state.copyWith(isLoadingMore: true, error: null));
    try {
      final result =
          await _favoritesRepository.addToFavorites(token, productId);
      emit(state.copyWith(
        isLoadingMore: false,
        isFavorited: true,
        favorites: result,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      ));
    }
  }

  // Remove from favorites (for favorites page)
  Future<void> removeFavorite(String token, int itemId) async {
    emit(state.copyWith(isLoadingMore: true, error: null));
    try {
      await _favoritesRepository.removeFavorite(token, itemId);
      final favorites = await _favoritesRepository.getFavorites(token);

      emit(state.copyWith(
        isLoadingMore: false,
        favorites: favorites,
        error: null,
      ));
    } on FavoritesEmptyFailure {
      emit(state.copyWith(
        status: FavoritesStatus.success,
        favorites: FavoritesModel(data: FavoritesData(items: [], count: 0)),
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      ));
    }
  }

  // Check if a product is favorited (for product details page)
  Future<void> checkIsFavorited(String token, int productId) async {
    try {
      final isFav = await _favoritesRepository.isFavorited(token, productId);
      emit(state.copyWith(isFavorited: isFav));
    } catch (e) {
      emit(state.copyWith(isFavorited: false, error: e.toString()));
    }
  }
}
