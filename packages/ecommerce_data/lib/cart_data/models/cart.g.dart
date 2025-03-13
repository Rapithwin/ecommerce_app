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
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          userId: $checkedConvert('userId', (v) => v as String),
          cartItems: $checkedConvert(
              'cartItems',
              (v) => (v as List<dynamic>)
                  .map((e) => CartItems.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

CartItems _$CartItemsFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CartItems',
      json,
      ($checkedConvert) {
        final val = CartItems(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          productId: $checkedConvert('productId', (v) => (v as num).toInt()),
          productName: $checkedConvert('productName', (v) => v as String),
          quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
        );
        return val;
      },
    );
