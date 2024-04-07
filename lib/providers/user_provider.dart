import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:thu_gom/models/user/user_model.dart';
import 'package:thu_gom/services/appwrite.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';

class UserProvider {
  final Account account = Account(Appwrite.instance.client);
  final Databases databases = Databases(Appwrite.instance.client);
  
  Future<void> updateName(String name) async {
    await account.updateName(name: name);
  }

  Future<UserModel> getUserData( uid) async {
    final response = await databases.getDocument(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.usersCollection,
      documentId: uid,
    );
    final user = UserModel.fromMap(response.data);
    return user;
  }

  Future<Document> updateUserData(uid, Map map) async {
    final response = await databases.updateDocument(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.usersCollection,
      documentId: uid,
      data: map,
    );
    return response;
  }

  Future<bool> checkSessionUserIfExists() async {
    try {
      await account.get();
      return true;
    } on AppwriteException catch (e) {
      if (e.code != 401 || e.type != 'general_unauthorized_scope') {
        return false;
      }
    }
    return false;
  }

  Future<bool> checkUserBlacklist(String userId) async {
    final result = await databases.listDocuments(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.usersCollection,
        queries: [
          Query.equal('uid', userId),
          Query.equal('role', 'blacklist')
        ]
    );
    if(result.total >= 1){
      return true;
    }else{
      return false;
    }
  }
}
