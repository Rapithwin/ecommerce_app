import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  final bool? isSuccess;
  final CommentData? data;
  final String? error;

  CommentModel({
    this.isSuccess,
    this.data,
    this.error,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}

@JsonSerializable()
class CommentData {
  final List<Comments> comments;
  final int count;
  final double averageRating;

  CommentData({
    required this.comments,
    required this.count,
    required this.averageRating,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) =>
      _$CommentDataFromJson(json);
}

@JsonSerializable()
class Comments {
  final int id;
  final int productId;
  final String userId;
  final String? userName;
  final String? content;
  final int rating;
  final String createdAt;

  Comments({
    required this.id,
    required this.productId,
    required this.userId,
    this.userName,
    this.content,
    required this.rating,
    required this.createdAt,
  });

  factory Comments.fromJson(Map<String, dynamic> json) =>
      _$CommentsFromJson(json);
}
