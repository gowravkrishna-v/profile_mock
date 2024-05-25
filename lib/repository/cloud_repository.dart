import 'package:profile_mock/model/album_model.dart';
import 'package:profile_mock/model/comment_model.dart';
import 'package:profile_mock/model/photo_model.dart';
import 'package:profile_mock/model/post_model.dart';
import 'package:profile_mock/model/profile_model.dart';
import 'package:profile_mock/utilities/isar_service.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';

class CloudRepository {
  final IsarService isarService = IsarService();
  Future<(List<AlbumModel>, String)> fetchAlbums(String userId) async {
    try {
      Uri url = Uri.parse(
          "https://jsonplaceholder.typicode.com/albums?userId=$userId");
      http.Response response = await http.get(url);
      List<AlbumModel> albums = albumModelFromJson(response.body);
      final Isar isar = await isarService.isar;
      await isar.writeTxn(() async {
        await isar.albumModels.putAll(albums);
      });
      return (albums, "");
    } catch (e) {
      return (<AlbumModel>[], e.toString());
    }
  }

  Future<(List<CommentModel>, String)> fetchComments(String postId) async {
    try {
      Uri url = Uri.parse(
          "https://jsonplaceholder.typicode.com/comments?postId=$postId");
      http.Response response = await http.get(url);
      List<CommentModel> comments = commentModelFromJson(response.body);
      final Isar isar = await isarService.isar;
      await isar.writeTxn(() async {
        await isar.commentModels.putAll(comments); // insert & update
      });
      return (comments, "");
    } catch (e) {
      return (<CommentModel>[], e.toString());
    }
  }

  Future<(List<PhotoModel>, String)> fetchPhotos(String albumId) async {
    try {
      Uri url = Uri.parse(
          "https://jsonplaceholder.typicode.com/photos?albumId=$albumId");
      http.Response response = await http.get(url);
      List<PhotoModel> photos = photoModelFromJson(response.body);
      final Isar isar = await isarService.isar;
      await isar.writeTxn(() async {
        await isar.photoModels.putAll(photos);
      });
      return (photos, "");
    } catch (e) {
      return (<PhotoModel>[], e.toString());
    }
  }

  Future<(List<PostModel>, String)> fetchPosts(String userId) async {
    try {
      Uri url = Uri.parse(
          "https://jsonplaceholder.typicode.com/posts?userId=$userId");
      http.Response response = await http.get(url);
      List<PostModel> posts = postModelFromJson(response.body);
      Isar isar = await isarService.isar;
      await isar.writeTxn(() async {
        await isar.postModels.putAll(posts);
      });
      return (posts, "");
    } catch (e) {
      return (<PostModel>[], e.toString());
    }
  }

  Future<(ProfileModel, String)> fetchProfile(String userId) async {
    try {
      Uri url =
          Uri.parse("https://jsonplaceholder.typicode.com/users?id=$userId");
      http.Response response = await http.get(url);
      List<ProfileModel> profile = profileModelFromJson(response.body);
      Isar isar = await isarService.isar;
      await isar.writeTxn(() async {
        await isar.profileModels.put(profile[0]);
      });
      return (profile.isNotEmpty ? profile[0] : ProfileModel(), "");
    } catch (e) {
      return (ProfileModel(), e.toString());
    }
  }
}
