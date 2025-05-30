import 'package:flutter/material.dart';

class CartErrorPage extends StatelessWidget {
  const CartErrorPage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
