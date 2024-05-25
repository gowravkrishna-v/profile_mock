// import 'package:profile_mock/model/album_model.dart';
// import 'package:profile_mock/utilities/isar_service.dart';
// import 'package:http/http.dart' as http;
// import 'package:isar/isar.dart';

// class AlbumRepository {
//   final IsarService isarService = IsarService();
//   Future<(List<AlbumModel>, String)> fetchAlbums(String userId) async {
//     try {
//       Uri url = Uri.parse(
//           "https://jsonplaceholder.typicode.com/albums?userId=$userId");
//       http.Response response = await http.get(url);
//       List<AlbumModel> albums = albumModelFromJson(response.body);
//       final Isar isar = await isarService.isar;
//       await isar.writeTxn(() async {
//         await isar.albumModels.putAll(albums);
//       });
//       return (albums, "");
//     } catch (e) {
//       return (<AlbumModel>[], e.toString());
//     }
//   }
// }
