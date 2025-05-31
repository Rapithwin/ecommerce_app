part of 'favorites_cubit.dart';

enum FavoritesStatus { initial, loading, success, failure }

extension FavoritesStatusX on FavoritesStatus {
  bool get isInitial => this == FavoritesStatus.initial;
  bool get isLoading => this == FavoritesStatus.loading;
  bool get isSuccess => this == FavoritesStatus.success;
  bool get isFailure => this == FavoritesStatus.failure;
}

final class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final FavoritesModel favorites;
  final bool isFavorited;
  final bool isLoadingMore;
  final String? error;

  const FavoritesState({
    this.status = FavoritesStatus.initial,
    required this.favorites,
    this.isFavorited = false,
    this.isLoadingMore = false,
    this.error,
  });

  FavoritesState copyWith({
    FavoritesStatus? status,
    FavoritesModel? favorites,
    bool? isFavorited,
    bool? isLoadingMore,
    String? error,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      isFavorited: isFavorited ?? this.isFavorited,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        favorites,
        isFavorited,
        isLoadingMore,
        error,
      ];
}
