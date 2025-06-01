import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/comments/bloc/comments_bloc.dart';
import 'package:e_commerce/products/presentation/cubit/products_cubit.dart';
import 'package:e_commerce_repository/products_repository/products_repostitory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class UserCommentsPage extends StatelessWidget {
  const UserCommentsPage({super.key});

  static Route<UserCommentsPage> route() => MaterialPageRoute(
        builder: (context) => const UserCommentsPage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(context.read<ProductsRepostitory>()),
      child: const UserCommentsView(),
    );
  }
}

class UserCommentsView extends StatefulWidget {
  const UserCommentsView({super.key});

  @override
  State<UserCommentsView> createState() => _UserCommentsViewState();
}

class _UserCommentsViewState extends State<UserCommentsView> {
  final Map<int, String> _productNames = {};

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      context
          .read<CommentsBloc>()
          .add(FetchUserComments(token: authState.token));
    }
  }

  Future<void> _fetchProductName(int productId) async {
    final productsCubit = context.read<ProductsCubit>();
    await productsCubit.fetchProductsById(id: productId);
    final productName = productsCubit.state.products.data?.isNotEmpty == true
        ? productsCubit.state.products.data![0].name
        : null;
    if (productName != null) {
      setState(() {
        _productNames[productId] = productName;
      });
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
            'دیدگاه‌های من',
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
      body: BlocConsumer<CommentsBloc, CommentsState>(
        listener: (context, state) {
          if (state is CommentDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'دیدگاه حذف شد.',
                  textDirection: TextDirection.rtl,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.onSecondary),
                ),
                backgroundColor: theme.colorScheme.secondary,
              ),
            );
            final authState = context.read<AuthBloc>().state;
            if (authState is Authenticated) {
              context
                  .read<CommentsBloc>()
                  .add(FetchUserComments(token: authState.token));
            }
          } else if (state is CommentsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is CommentsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CommentsError) {
            return Center(child: Text(state.message));
          } else if (state is UserCommentsLoaded) {
            final comments = state.comments;
            if (comments.isEmpty) {
              return Center(
                  child: Text(
                'شما هنوز دیدگاهی ثبت نکرده‌اید.',
                textDirection: TextDirection.rtl,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(color: theme.colorScheme.onSurface),
              ));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: comments.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final comment = comments[index];
                final productId = comment.productId;
                final productName = _productNames[productId];
                if (productName == null) {
                  _fetchProductName(productId);
                }
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListTile(
                    title: Text(
                      comment.content ?? '',
                      textDirection: TextDirection.rtl,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName != null
                              ? 'محصول: $productName'
                              : 'در حال دریافت نام محصول...',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.colorScheme.onSurface),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(comment.rating.toString()),
                            const Icon(Icons.star,
                                color: Colors.amber, size: 18),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateTime.parse(comment.createdAt).toPersianDate(),
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.colorScheme.onSurface),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        final authState = context.read<AuthBloc>().state;
                        if (authState is Authenticated) {
                          context.read<CommentsBloc>().add(DeleteComment(
                                token: authState.token,
                                commentId: comment.id,
                                productId: comment.productId,
                              ));
                        }
                      },
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
