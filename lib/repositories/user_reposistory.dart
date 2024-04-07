import 'package:appwrite/models.dart';
import 'package:thu_gom/models/user/user_model.dart';
import 'package:thu_gom/providers/user_provider.dart';

class UserRepository {
  UserProvider userProvider;
  UserRepository(this.userProvider);

  // Future<void> updateName(String name) async {
  //   await userProvider.updateName(name);
  // }

  Future<UserModel> getUserData(uuid) async {
    final response = await userProvider.getUserData(uuid);
    return response;
  }
  Future<Document> updateUserData(uuid, Map map) async {
    final response = await userProvider.updateUserData(uuid, map);
    return response;
  }

  Future<bool> checkSessionUserIfExists() async {
    final response = await userProvider.checkSessionUserIfExists();
    return response;
  }

  Future<bool> checkUserBlacklist(String userId) async {
    final response = await userProvider.checkUserBlacklist(userId);
    return response;
  }
}