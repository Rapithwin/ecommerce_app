// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CommentModel',
      json,
      ($checkedConvert) {
        final val = CommentModel(
          isSuccess: $checkedConvert('isSuccess', (v) => v as bool?),
          data: $checkedConvert(
              'data',
              (v) => v == null
                  ? null
                  : CommentData.fromJson(v as Map<String, dynamic>)),
          error: $checkedConvert('error', (v) => v as String?),
        );
        return val;
      },
    );

UserCommentModel _$UserCommentModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UserCommentModel',
      json,
      ($checkedConvert) {
        final val = UserCommentModel(
          isSuccess: $checkedConvert('isSuccess', (v) => v as bool?),
          data: $checkedConvert(
              'data',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Comments.fromJson(e as Map<String, dynamic>))
                  .toList()),
          error: $checkedConvert('error', (v) => v as String?),
        );
        return val;
      },
    );

CommentData _$CommentDataFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CommentData',
      json,
      ($checkedConvert) {
        final val = CommentData(
          comments: $checkedConvert(
              'comments',
              (v) => (v as List<dynamic>)
                  .map((e) => Comments.fromJson(e as Map<String, dynamic>))
                  .toList()),
          count: $checkedConvert('count', (v) => (v as num).toInt()),
          averageRating:
              $checkedConvert('averageRating', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Comments _$CommentsFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Comments',
      json,
      ($checkedConvert) {
        final val = Comments(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          productId: $checkedConvert('productId', (v) => (v as num).toInt()),
          userId: $checkedConvert('userId', (v) => v as String),
          userName: $checkedConvert('userName', (v) => v as String?),
          content: $checkedConvert('content', (v) => v as String?),
          rating: $checkedConvert('rating', (v) => (v as num).toInt()),
          createdAt: $checkedConvert('createdAt', (v) => v as String),
        );
        return val;
      },
    );
