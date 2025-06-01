part of 'comments_bloc.dart';

sealed class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object?> get props => [];
}

class FetchComments extends CommentsEvent {
  final String token;
  final int productId;
  const FetchComments({required this.token, required this.productId});

  @override
  List<Object?> get props => [token, productId];
}

class PostComment extends CommentsEvent {
  final String token;
  final String content;
  final int productId;
  final int rating;
  const PostComment({
    required this.token,
    required this.content,
    required this.productId,
    required this.rating,
  });

  @override
  List<Object?> get props => [token, content, productId, rating];
}

class DeleteComment extends CommentsEvent {
  final String token;
  final int commentId;
  final int productId;
  const DeleteComment({
    required this.token,
    required this.commentId,
    required this.productId,
  });

  @override
  List<Object?> get props => [token, commentId, productId];
}

class FetchUserComments extends CommentsEvent {
  final String token;
  const FetchUserComments({required this.token});

  @override
  List<Object?> get props => [token];
}
