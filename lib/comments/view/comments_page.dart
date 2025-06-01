import 'package:flutter/material.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  static Route<CommentsPage> route() {
    return MaterialPageRoute(
      builder: (context) => const CommentsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const CommentsView();
  }
}

class CommentsView extends StatelessWidget {
  const CommentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
