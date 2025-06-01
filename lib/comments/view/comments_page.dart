import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/comments/bloc/comments_bloc.dart';
import 'package:e_commerce/comments/view/post_comments_page.dart';
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'دیدگاه کاربران',
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
      body: BlocBuilder<CommentsBloc, CommentsState>(
        builder: (context, state) {
          if (state is CommentsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CommentsError) {
            return Center(child: Text(state.message));
          } else if (state is CommentsLoaded) {
            final comments = state.comments;
            if (comments.isEmpty) {
              return const Center(
                  child: Text(
                'دیدگاهی ثبت نشده است.',
                textDirection: TextDirection.rtl,
              ));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: comments.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListTile(
                    title: Text(
                      comment.userName ?? 'کاربر',
                      textDirection: TextDirection.rtl,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.content ?? '',
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              comment.rating.toString(),
                              textDirection: TextDirection.rtl,
                            ),
                            const Icon(Icons.star,
                                color: Colors.amber, size: 18),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          comment.createdAt,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.colorScheme.onSurface),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => const PostCommentsPage(),
              settings: RouteSettings(arguments: widget.productId),
            ),
          )
              .then((value) {
            if (!context.mounted) return;
            final authState = context.read<AuthBloc>().state;
            if (authState is Authenticated) {
              context.read<CommentsBloc>().add(FetchComments(
                  token: authState.token, productId: widget.productId));
            }
          });
        },
        tooltip: 'ثبت دیدگاه',
        child: const Icon(Icons.add_comment),
      ),
    );
  }
}
