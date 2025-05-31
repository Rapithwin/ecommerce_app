import 'package:flutter/material.dart';

class FavoritesLoading extends StatelessWidget {
  const FavoritesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
