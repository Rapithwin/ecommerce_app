import 'package:json_annotation/json_annotation.dart';

part 'favorites_model.g.dart';

@JsonSerializable()
class FavoritesModel {
  final bool? isSuccess;
  final FavoritesData? data;
  final String? error;

  FavoritesModel({
    this.isSuccess,
    this.data,
    this.error,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) =>
      _$FavoritesModelFromJson(json);
}

@JsonSerializable()
class FavoritesData {
  final List<FavoritedItems>? items;
  final int? count;

  FavoritesData({this.items, this.count});
  factory FavoritesData.fromJson(Map<String, dynamic> json) =>
      _$FavoritesDataFromJson(json);
}

@JsonSerializable()
class FavoritedItems {
  final int? id;
  final int? productId;
  final String? productName;
  final double? productPrice;

  FavoritedItems({
    this.id,
    this.productId,
    this.productName,
    this.productPrice,
  });

  factory FavoritedItems.fromJson(Map<String, dynamic> json) =>
      _$FavoritedItemsFromJson(json);
}
