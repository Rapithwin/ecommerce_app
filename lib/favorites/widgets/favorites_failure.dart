import 'package:flutter/material.dart';

class FavoritesFailure extends StatelessWidget {
  const FavoritesFailure({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
