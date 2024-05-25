// import 'package:profile_mock/model/photo_model.dart';
// import 'package:profile_mock/utilities/isar_service.dart';
// import 'package:http/http.dart' as http;
// import 'package:isar/isar.dart';

// class PhotoRepository {
//   final IsarService isarService = IsarService();
//   Future<(List<PhotoModel>, String)> fetchPhotos(String albumId) async {
//     try {
//       Uri url = Uri.parse(
//           "https://jsonplaceholder.typicode.com/photos?albumId=$albumId");
//       http.Response response = await http.get(url);
//       List<PhotoModel> photos = photoModelFromJson(response.body);
//       final Isar isar = await isarService.isar;
//       await isar.writeTxn(() async {
//         await isar.photoModels.putAll(photos);
//       });
//       return (photos, "");
//     } catch (e) {
//       return (<PhotoModel>[], e.toString());
//     }
//   }
// }
