import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/comments/bloc/comments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key, required this.productId});

  final int productId;

  static Route<CommentsPage> route(int productId) {
    return MaterialPageRoute(
      builder: (context) => CommentsPage(
        productId: productId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommentsView(
      productId: productId,
    );
  }
}

class CommentsView extends StatefulWidget {
  const CommentsView({super.key, required this.productId});
  final int productId;

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      context.read<CommentsBloc>().add(FetchComments(
            token: authState.token,
            productId: widget.productId,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
