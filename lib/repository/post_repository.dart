// import 'package:profile_mock/model/post_model.dart';
// import 'package:profile_mock/utilities/isar_service.dart';
// import 'package:http/http.dart' as http;
// import 'package:isar/isar.dart';

// class PostRepository {
//   final IsarService isarService = IsarService();
//   Future<(List<PostModel>, String)> fetchPosts(String userId) async {
//     try {
//       Uri url = Uri.parse(
//           "https://jsonplaceholder.typicode.com/posts?userId=$userId");
//       http.Response response = await http.get(url);
//       List<PostModel> posts = postModelFromJson(response.body);
//       Isar isar = await isarService.isar;
//       await isar.writeTxn(() async {
//         await isar.postModels.putAll(posts);
//       });
//       return (posts, "");
//     } catch (e) {
//       return (<PostModel>[], e.toString());
//     }
//   }
// }
