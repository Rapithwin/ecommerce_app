import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/comments/bloc/comments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contentController = TextEditingController();
  int _rating = 5;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as int?;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'ثبت دیدگاه',
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  controller: _contentController,
                  maxLines: 4,
                  textDirection: TextDirection.rtl,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.onSurface),
                  decoration: const InputDecoration(
                    labelText: 'متن دیدگاه',
                    hintTextDirection: TextDirection.rtl,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'متن دیدگاه را وارد کنید'
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 8),
                  DropdownButton<int>(
                    value: _rating,
                    items: List.generate(5, (i) => i + 1)
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.toString(),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface),
                              ),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _rating = val);
                    },
                  ),
                  Text(
                    'امتیاز:',
                    textDirection: TextDirection.rtl,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.colorScheme.onSurface),
                  )
                ],
              ),
              const SizedBox(height: 24),
              BlocConsumer<CommentsBloc, CommentsState>(
                listener: (context, state) {
                  if (state is CommentPosted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'دیدگاه شما ثبت شد!',
                          textDirection: TextDirection.rtl,
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is CommentsError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message.contains("update")
                              ? "شما برای این کالا قبلا دیدگاه ثبت کرده‌اید"
                              : state.message,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.colorScheme.onError),
                        ),
                        backgroundColor: theme.colorScheme.error,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is CommentPosting
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              final auth = context.read<AuthBloc>().state;
                              if (auth is Authenticated && productId != null) {
                                context.read<CommentsBloc>().add(PostComment(
                                      token: auth.token,
                                      content: _contentController.text,
                                      productId: productId,
                                      rating: _rating,
                                    ));
                              }
                            }
                          },
                    child: state is CommentPosting
                        ? const CircularProgressIndicator()
                        : const Text('ثبت دیدگاه'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
