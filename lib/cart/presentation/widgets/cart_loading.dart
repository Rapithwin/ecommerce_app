import 'package:flutter/material.dart';

class CartLoadingPage extends StatelessWidget {
  const CartLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
