// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Cart',
      json,
      ($checkedConvert) {
        final val = Cart(
          isSuccess: $checkedConvert('isSuccess', (v) => v as bool?),
          data: $checkedConvert(
              'data',
              (v) => v == null
                  ? null
                  : CartData.fromJson(v as Map<String, dynamic>)),
          error: $checkedConvert('error', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'data': instance.data,
      'error': instance.error,
    };

CartData _$CartDataFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CartData',
      json,
      ($checkedConvert) {
        final val = CartData(
          id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
          userId: $checkedConvert('userId', (v) => v as String?),
          items: $checkedConvert(
              'items',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => CartItems.fromJson(e as Map<String, dynamic>))
                  .toList()),
          totalPrice:
              $checkedConvert('totalPrice', (v) => (v as num?)?.toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$CartDataToJson(CartData instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'items': instance.items,
      'totalPrice': instance.totalPrice,
    };

CartItems _$CartItemsFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CartItems',
      json,
      ($checkedConvert) {
        final val = CartItems(
          id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
          productId: $checkedConvert('productId', (v) => (v as num?)?.toInt()),
          productName: $checkedConvert('productName', (v) => v as String?),
          unitPrice:
              $checkedConvert('unitPrice', (v) => (v as num?)?.toDouble()),
          quantity: $checkedConvert('quantity', (v) => (v as num?)?.toInt()),
          totalPrice:
              $checkedConvert('totalPrice', (v) => (v as num?)?.toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$CartItemsToJson(CartItems instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productName': instance.productName,
      'unitPrice': instance.unitPrice,
      'quantity': instance.quantity,
      'totalPrice': instance.totalPrice,
    };
