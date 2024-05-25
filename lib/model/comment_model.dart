import 'dart:convert';

import 'package:isar/isar.dart';

part 'comment_model.g.dart';

List<CommentModel> commentModelFromJson(String str) => List<CommentModel>.from(
    json.decode(str).map((x) => CommentModel.fromJson(x)));

String commentModelToJson(List<CommentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@collection
class CommentModel {
  int? postId;
  Id? id;
  String? name;
  String? email;
  String? body;

  CommentModel({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  CommentModel copyWith({
    int? postId,
    Id? id,
    String? name,
    String? email,
    String? body,
  }) =>
      CommentModel(
        postId: postId ?? this.postId,
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        body: body ?? this.body,
      );

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
      };
}
