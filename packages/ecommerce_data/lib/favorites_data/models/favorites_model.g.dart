// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'favorites_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritesModel _$FavoritesModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FavoritesModel',
      json,
      ($checkedConvert) {
        final val = FavoritesModel(
          isSuccess: $checkedConvert('isSuccess', (v) => v as bool?),
          data: $checkedConvert(
              'data',
              (v) => v == null
                  ? null
                  : FavoritesData.fromJson(v as Map<String, dynamic>)),
          error: $checkedConvert('error', (v) => v as String?),
        );
        return val;
      },
    );

FavoritesData _$FavoritesDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FavoritesData',
      json,
      ($checkedConvert) {
        final val = FavoritesData(
          items: $checkedConvert(
              'items',
              (v) => (v as List<dynamic>?)
                  ?.map(
                      (e) => FavoritedItems.fromJson(e as Map<String, dynamic>))
                  .toList()),
          count: $checkedConvert('count', (v) => (v as num?)?.toInt()),
        );
        return val;
      },
    );

FavoritedItems _$FavoritedItemsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FavoritedItems',
      json,
      ($checkedConvert) {
        final val = FavoritedItems(
          id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
          productId: $checkedConvert('productId', (v) => (v as num?)?.toInt()),
          productName: $checkedConvert('productName', (v) => v as String?),
          productPrice:
              $checkedConvert('productPrice', (v) => (v as num?)?.toDouble()),
        );
        return val;
      },
    );
