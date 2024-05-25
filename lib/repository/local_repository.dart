import 'package:profile_mock/model/album_model.dart';
import 'package:profile_mock/model/comment_model.dart';
import 'package:profile_mock/model/photo_model.dart';
import 'package:profile_mock/model/post_model.dart';
import 'package:profile_mock/model/profile_model.dart';
import 'package:profile_mock/utilities/isar_service.dart';
import 'package:isar/isar.dart';

class LocalRepository {
  final IsarService isarService = IsarService();
  Future<(List<AlbumModel>, String)> fetchAlbumsFromLocal(int userId) async {
    try {
      Isar isar = await isarService.isar;
      List<AlbumModel> albums =
          await isar.albumModels.filter().userIdEqualTo(userId).findAll();
      return (albums, "");
    } catch (e) {
      return (<AlbumModel>[], e.toString());
    }
  }

  Future<(List<PhotoModel>, String)> fetchPhotosFromLocal(int albumId) async {
    try {
      Isar isar = await isarService.isar;
      List<PhotoModel> photos =
          await isar.photoModels.filter().albumIdEqualTo(albumId).findAll();
      return (photos, "");
    } catch (e) {
      return (<PhotoModel>[], e.toString());
    }
  }

  Future<(List<CommentModel>, String)> fetchCommentsFromLocal(
      int postId) async {
    try {
      Isar isar = await isarService.isar;
      List<CommentModel> comments =
          await isar.commentModels.filter().postIdEqualTo(postId).findAll();
      return (comments, "");
    } catch (e) {
      return (<CommentModel>[], e.toString());
    }
  }

  Future<(List<PostModel>, String)> fetchPostsFromLocal(int userId) async {
    try {
      Isar isar = await isarService.isar;
      List<PostModel> posts =
          await isar.postModels.filter().userIdEqualTo(userId).findAll();
      return (posts, "");
    } catch (e) {
      return (<PostModel>[], e.toString());
    }
  }

  Future<(ProfileModel, String)> fetchProfileFromLocal(int userId) async {
    try {
      Isar isar = await isarService.isar;
      ProfileModel? profile =
          await isar.profileModels.filter().idEqualTo(userId).findFirst();
      return (profile ?? ProfileModel(), "");
    } catch (e) {
      return (ProfileModel(), e.toString());
    }
  }
}
