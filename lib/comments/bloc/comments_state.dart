part of 'comments_bloc.dart';

// The Comments type is defined in the imported model in the parent file.
// Use List<dynamic> for comments in part file, and cast in the bloc implementation.

sealed class CommentsState extends Equatable {
  const CommentsState();
  @override
  List<Object?> get props => [];
}

final class CommentsInitial extends CommentsState {}

final class CommentsLoading extends CommentsState {}

final class CommentsLoaded extends CommentsState {
  final List<dynamic> comments;
  final int count;
  final double averageRating;
  const CommentsLoaded({
    required this.comments,
    required this.count,
    required this.averageRating,
  });
  @override
  List<Object?> get props => [comments, count, averageRating];
}

final class CommentsError extends CommentsState {
  final String message;
  const CommentsError(this.message);
  @override
  List<Object?> get props => [message];
}

final class CommentPosting extends CommentsState {}

final class CommentPosted extends CommentsState {}

final class CommentDeleting extends CommentsState {}

final class CommentDeleted extends CommentsState {}

final class UserCommentsLoaded extends CommentsState {
  final List<dynamic> comments;
  const UserCommentsLoaded({required this.comments});
  @override
  List<Object?> get props => [comments];
}
