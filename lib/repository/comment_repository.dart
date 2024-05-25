// import 'package:profile_mock/model/comment_model.dart';
// import 'package:profile_mock/utilities/isar_service.dart';
// import 'package:http/http.dart' as http;
// import 'package:isar/isar.dart';

// class CommentRepository {
//   final IsarService isarService = IsarService();
//   Future<(List<CommentModel>, String)> fetchComments(String postId) async {
//     try {
//       Uri url = Uri.parse(
//           "https://jsonplaceholder.typicode.com/comments?postId=$postId");
//       http.Response response = await http.get(url);
//       List<CommentModel> comments = commentModelFromJson(response.body);
//       final Isar isar = await isarService.isar;
//       await isar.writeTxn(() async {
//         await isar.commentModels.putAll(comments); // insert & update
//       });
//       return (comments, "");
//     } catch (e) {
//       return (<CommentModel>[], e.toString());
//     }
//   }
// }
