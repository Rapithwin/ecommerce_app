import 'package:e_commerce_data/comments_data/comment_api_client.dart';
import 'package:e_commerce_data/comments_data/models/comment_model.dart';

class CommentsRepository {
  final CommentApiClient _commentApiClient;
  CommentsRepository({CommentApiClient? commentApi})
      : _commentApiClient = commentApi ?? CommentApiClient();

  Future<CommentModel> getAllComments(String token, int productId) async =>
      await _commentApiClient.getAllComments(token, productId);

  Future<UserCommentModel> getUserComments(String token) async =>
      await _commentApiClient.getUserComments(token);

  Future<CommentModel> postComment({
    required String token,
    required String content,
    required int productId,
    required int rating,
  }) async =>
      _commentApiClient.postComment(
        token: token,
        content: content,
        productId: productId,
        rating: rating,
      );

  Future<bool> deleteComment(String token, int commentId) async =>
      _commentApiClient.deleteComment(token, commentId);
}
