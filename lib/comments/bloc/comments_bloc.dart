import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_repository/comments_repository/comments_repository.dart';
import 'package:e_commerce_data/comments_data/comment_api_client.dart'
    show CommentsEmptyFailure;

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentsRepository commentsRepository;
  CommentsBloc({required this.commentsRepository}) : super(CommentsInitial()) {
    on<FetchComments>(_onFetchComments);
    on<PostComment>(_onPostComment);
    on<DeleteComment>(_onDeleteComment);
    on<FetchUserComments>(_onFetchUserComments);
  }

  Future<void> _onFetchComments(
      FetchComments event, Emitter<CommentsState> emit) async {
    emit(CommentsLoading());
    try {
      final commentModel =
          await commentsRepository.getAllComments(event.token, event.productId);
      final data = commentModel.data;
      emit(CommentsLoaded(
        comments: data?.comments ?? [],
        count: data?.count ?? 0,
        averageRating: data?.averageRating ?? 0.0,
      ));
    } catch (e) {
      if (e is CommentsEmptyFailure) {
        emit(const CommentsLoaded(comments: [], count: 0, averageRating: 0.0));
      } else {
        emit(CommentsError(e.toString()));
      }
    }
  }

  Future<void> _onPostComment(
      PostComment event, Emitter<CommentsState> emit) async {
    emit(CommentPosting());
    try {
      final result = await commentsRepository.postComment(
        token: event.token,
        content: event.content,
        productId: event.productId,
        rating: event.rating,
      );
      if (result.isSuccess == true) {
        emit(CommentPosted());
        add(FetchComments(token: event.token, productId: event.productId));
      } else {
        emit(CommentsError(result.error ?? 'خطا در ثبت دیدگاه'));
      }
    } catch (e) {
      emit(CommentsError(e.toString()));
    }
  }

  Future<void> _onDeleteComment(
      DeleteComment event, Emitter<CommentsState> emit) async {
    emit(CommentDeleting());
    try {
      final result =
          await commentsRepository.deleteComment(event.token, event.commentId);
      if (result) {
        emit(CommentDeleted());
        add(FetchComments(token: event.token, productId: event.productId));
      } else {
        emit(const CommentsError('خطا در حذف دیدگاه'));
      }
    } catch (e) {
      emit(CommentsError(e.toString()));
    }
  }

  Future<void> _onFetchUserComments(
      FetchUserComments event, Emitter<CommentsState> emit) async {
    emit(CommentsLoading());
    try {
      final userCommentsModel =
          await commentsRepository.getUserComments(event.token);
      emit(UserCommentsLoaded(comments: userCommentsModel.data ?? []));
    } catch (e) {
      if (e is CommentsEmptyFailure) {
        emit(const UserCommentsLoaded(comments: []));
      } else {
        emit(CommentsError(e.toString()));
      }
    }
  }
}
