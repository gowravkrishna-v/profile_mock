import 'package:profile_mock/model/album_model.dart';
import 'package:profile_mock/model/comment_model.dart';
import 'package:profile_mock/model/photo_model.dart';
import 'package:profile_mock/model/post_model.dart';
import 'package:profile_mock/model/profile_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> isar;
  IsarService() {
    isar = openIsar();
  }
  Future<Isar> openIsar() async {
    var dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [
          AlbumModelSchema,
          PhotoModelSchema,
          PostModelSchema,
          CommentModelSchema,
          ProfileModelSchema,
        ],
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
