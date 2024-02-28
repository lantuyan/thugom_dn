
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:thu_gom/services/appwrite.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';

class UserRequestTrashProvider {
  Account? account;
  Storage? storage;
  Databases? databases;

  UserRequestTrashProvider() {
    account = Account(Appwrite.instance.client);
    storage = Storage(Appwrite.instance.client);
    databases = Databases(Appwrite.instance.client);
  }

  
  Future<models.DocumentList> getRequestOfUserFromAppwrite() async {
    final response = await databases!.listDocuments(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.categoryCollectionId);

    return response;
  }

  Future<models.DocumentList> getRequest() async {
    final response = await databases!.listDocuments(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.userRequestTrashCollection);
    return response;
  }

  // Future<models.File> uploadCategoryImage(String imagePath) {
  //   String fileName = "${DateTime.now().microsecondsSinceEpoch}"
  //       "${imagePath.split(".").last}";
  //   final response = storage!.createFile(
  //       bucketId: AppWriteConstants.categoryBucketId,
  //       fileId: ID.unique(),
  //       file: InputFile.fromPath(path: imagePath, filename: fileName));

  //   return response;
  // }

  // Future<dynamic> deleteCategoryImage(String fileId) {
  //   final response = storage!.deleteFile(
  //     bucketId: AppWriteConstants.categoryBucketId,
  //     fileId: ID.unique(),
  //   );

  //   return response;
  // }

  // Future<models.Document> createCategory(Map map) async {
  //   final response = databases!.createDocument(
  //       databaseId: AppWriteConstants.databaseId,
  //       collectionId: AppWriteConstants.categoryCollectionId,
  //       documentId: ID.unique(),
  //       data: {
  //         "category_name": map["category_name"],
  //         "category_image": map["category_image"],
  //         "categoryID": map["category_image"]
  //       });

  //   return response;
  // }


  //   Future<models.DocumentList> getCategoryDetail() async {
  //   final response = await databases!.listDocuments(
  //       databaseId: AppWriteConstants.databaseId,
  //       collectionId: AppWriteConstants.categoryDetailCollectionId);

  //   return response;
  // }
}
