// import 'package:profile_mock/model/profile_model.dart';
// import 'package:profile_mock/utilities/isar_service.dart';
// import 'package:http/http.dart' as http;
// import 'package:isar/isar.dart';

// class ProfileRepository {
//   final IsarService isarService = IsarService();
//   Future<(ProfileModel, String)> fetchProfile(String userId) async {
//     try {
//       Uri url =
//           Uri.parse("https://jsonplaceholder.typicode.com/users?id=$userId");
//       http.Response response = await http.get(url);
//       List<ProfileModel> profile = profileModelFromJson(response.body);
//       Isar isar = await isarService.isar;
//       await isar.writeTxn(() async {
//         await isar.profileModels.put(profile[0]);
//       });
//       return (profile.isNotEmpty ? profile[0] : ProfileModel(), "");
//     } catch (e) {
//       return (ProfileModel(), e.toString());
//     }
//   }
// }
