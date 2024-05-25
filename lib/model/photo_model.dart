import 'dart:convert';

import 'package:isar/isar.dart';

part 'photo_model.g.dart';

List<PhotoModel> photoModelFromJson(String str) =>
    List<PhotoModel>.from(json.decode(str).map((x) => PhotoModel.fromJson(x)));

String photoModelToJson(List<PhotoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@collection
class PhotoModel {
  int? albumId;
  Id? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  PhotoModel({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  PhotoModel copyWith({
    int? albumId,
    Id? id,
    String? title,
    String? url,
    String? thumbnailUrl,
  }) =>
      PhotoModel(
        albumId: albumId ?? this.albumId,
        id: id ?? this.id,
        title: title ?? this.title,
        url: url ?? this.url,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      );

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
}
