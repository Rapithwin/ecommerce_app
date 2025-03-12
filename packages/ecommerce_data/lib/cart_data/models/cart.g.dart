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
          userId: $checkedConvert('user_id', (v) => v as String),
          cartItems: $checkedConvert('cart_items',
              (v) => CartItems.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'userId': 'user_id', 'cartItems': 'cart_items'},
    );

CartItems _$CartItemsFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CartItems',
      json,
      ($checkedConvert) {
        final val = CartItems(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          productId: $checkedConvert('product_id', (v) => (v as num).toInt()),
          productName: $checkedConvert('product_name', (v) => v as String),
          quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'productId': 'product_id',
        'productName': 'product_name'
      },
    );
