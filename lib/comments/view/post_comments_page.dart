import 'package:flutter/material.dart';

class PostCommentsPage extends StatelessWidget {
  const PostCommentsPage({super.key});

  static Route<PostCommentsPage> route() {
    return MaterialPageRoute(
      builder: (context) => PostCommentsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PostCommentsView();
  }
}

class PostCommentsView extends StatefulWidget {
  const PostCommentsView({super.key});

  @override
  State<PostCommentsView> createState() => _PostCommentsViewState();
}

class _PostCommentsViewState extends State<PostCommentsView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
