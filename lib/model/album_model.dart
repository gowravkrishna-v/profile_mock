import 'dart:convert';

import 'package:isar/isar.dart';

part 'album_model.g.dart';

List<AlbumModel> albumModelFromJson(String str) =>
    List<AlbumModel>.from(json.decode(str).map((x) => AlbumModel.fromJson(x)));

String albumModelToJson(List<AlbumModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@collection
class AlbumModel {
  int? userId;
  Id? id;
  String? title;

  AlbumModel({
    this.userId,
    this.id,
    this.title,
  });

  AlbumModel copyWith({
    int? userId,
    Id? id,
    String? title,
  }) =>
      AlbumModel(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
      );

  factory AlbumModel.fromJson(Map<String, dynamic> json) => AlbumModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
