import 'package:flutter/material.dart';

class DetailsLoading extends StatelessWidget {
  const DetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
