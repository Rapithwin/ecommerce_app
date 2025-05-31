import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:e_commerce_data/comments_data/models/comment_model.dart';
import 'package:e_commerce_data/data_constants.dart';
import 'package:http/http.dart' as http;

class CommentsEmptyFailure implements Exception {}

class CommentApiClient {
  CommentApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  final _commentEndpoint = "api/comments";

  Future<CommentModel> getAllComments(String token, int productId) async {
    final commentRequest = Uri.http(
      Constants.authority,
      "$_commentEndpoint/product/$productId",
    );
    try {
      final commentResponse = await _httpClient.get(
        commentRequest,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      final commentJson =
          jsonDecode(commentResponse.body) as Map<String, dynamic>;
      final result = CommentModel.fromJson(commentJson);
      if (result.data != null && result.data!.comments.isEmpty) {
        throw CommentsEmptyFailure();
      }
      return result;
    } catch (error, stacktrace) {
      log("Error during api call $error");
      log("Stacktrace $stacktrace");
      rethrow;
    }
  }

  Future<UserCommentModel> getUserComments(String token) async {
    final commentRequest = Uri.http(
      Constants.authority,
      "$_commentEndpoint/user",
    );
    try {
      final commentResponse = await _httpClient.get(
        commentRequest,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      final commentJson =
          jsonDecode(commentResponse.body) as Map<String, dynamic>;
      final result = UserCommentModel.fromJson(commentJson);
      if (result.data != null && result.data!.isEmpty) {
        throw CommentsEmptyFailure();
      }
      return result;
    } catch (error, stacktrace) {
      log("Error during api call $error");
      log("Stacktrace $stacktrace");
      rethrow;
    }
  }

  Future<CommentModel> postComment({
    required String token,
    required String content,
    required int productId,
    required int rating,
  }) async {
    final commentRequest = Uri.http(
      Constants.authority,
      _commentEndpoint,
    );
    try {
      final commentResponse = await _httpClient.post(
        commentRequest,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode({
          "productId": productId,
          "content": content,
          "rating": rating,
        }),
      );
      if (commentResponse.statusCode == 201) {
        return CommentModel(
          isSuccess: true,
        );
      } else {
        final json = jsonDecode(commentResponse.body) as Map<String, dynamic>;
        return CommentModel(
          isSuccess: false,
          error: json['error'],
        );
      }
    } catch (error, stacktrace) {
      log("Error during api call $error");
      log("Stacktrace $stacktrace");
      rethrow;
    }
  }
}
