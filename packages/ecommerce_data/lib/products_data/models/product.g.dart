// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Product',
      json,
      ($checkedConvert) {
        final val = Product(
          data: $checkedConvert(
              'data',
              (v) => (v as List<dynamic>)
                  .map((e) => ProductData.fromJson(e as Map<String, dynamic>))
                  .toList()),
          error: $checkedConvert('error', (v) => v as String?),
        );
        return val;
      },
    );

ProductData _$ProductDataFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ProductData',
      json,
      ($checkedConvert) {
        final val = ProductData(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          price: $checkedConvert('price', (v) => (v as num).toInt()),
          stockQuantity:
              $checkedConvert('stockQuantity', (v) => (v as num).toInt()),
        );
        return val;
      },
    );
