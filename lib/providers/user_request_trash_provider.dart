import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/services/appwrite.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';

class UserRequestTrashProvider {
  late Account account;
  late Storage storage;
  late Databases databases;

  UserRequestTrashProvider() {
    account = Account(Appwrite.instance.client);
    storage = Storage(Appwrite.instance.client);
    databases = Databases(Appwrite.instance.client);
  }

  Future<models.DocumentList> getRequestOfUserFromAppwrite() async {
    final response = await databases!.listDocuments(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.userRequestTrashCollection);

    return response;
  }
  // LIST REQUEST OF USER
  Future<models.DocumentList> getRequestWithStatusPending() async {
    final GetStorage _getStorage = GetStorage();
    final userID = _getStorage.read('userId');
    final response = await databases!.listDocuments(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      queries: [
        Query.equal('status', 'pending'),
        Query.equal('senderId', userID)
      ],
    );
    return response;
  }
    // LIST REQUEST OF COLLECTOR
    Future<models.DocumentList> getRequestListColletor() async {
    final response = await databases!.listDocuments(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      queries: [
        Query.equal('status', 'pending'),
      ],
    );
    return response;
  }

  Future<models.DocumentList> getRequestHistory() async {
    final GetStorage _getStorage = GetStorage();
    final userID = _getStorage.read('userId');
    final response = await databases!.listDocuments(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      queries: [
        Query.notEqual('status', 'pending'),
        Query.equal('senderId', userID)
      ],
    );
    return response;
  }

  Future<models.DocumentList> getRequestListConfirmColletor() async {
    final GetStorage _getStorage = GetStorage();
    final userID = _getStorage.read('userId');
    final response = await databases!.listDocuments(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      queries: [
        Query.equal('confirm', userID)
      ],
    );
    return response;
  }

  Future<void> cancelRequest(String requestId) async {
    await databases?.updateDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.userRequestTrashCollection,
        documentId: requestId,
        data:{
          'status' : 'cancel',
        }
    );
  }
  Future<void> hiddenRequest(String requestId, List<String> hidden) async {
    await databases?.updateDocument(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      documentId: requestId,
      data: {'hidden': hidden},
    );
  }

  Future<void> confirmRequest(String requestId, String userId) async {
    await databases?.updateDocument(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      documentId: requestId,
      data: {'confirm': userId,'status': 'finish'},
    );
  }

  Future sendRequestToAppwrite(
      UserRequestTrashModel userRequestTrashModel) async {
    try {
      await databases.createDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.userRequestTrashCollection,
          documentId: userRequestTrashModel.requestId,
          data: {
            "senderId": userRequestTrashModel.senderId,
            "image": userRequestTrashModel.image,
            "phone_number": userRequestTrashModel.phone_number,
            "address": userRequestTrashModel.address,
            "description": userRequestTrashModel.description,
            "point_lat": userRequestTrashModel.point_lat,
            "point_lng": userRequestTrashModel.point_lng,
            "status": userRequestTrashModel.status,
            "confirm": userRequestTrashModel.confirm,
            "hidden": userRequestTrashModel.hidden,
            "trash_type": userRequestTrashModel.trash_type,
            "createAt": userRequestTrashModel.createAt,
            "updateAt": userRequestTrashModel.updateAt,
          });
      print("sendRequestToAppwrite");
    } catch (e) {
      print("sendRequestToAppwrite error: $e");
    }
  }

  Future<models.File> uploadCategoryImage(String imagePath) {
    String fileName = "${DateTime.now().microsecondsSinceEpoch}"
        "${imagePath.split(".").last}";
    final response = storage.createFile(
        bucketId: AppWriteConstants.userRequestTrashBucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: imagePath, filename: fileName));

    return response;
  }

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
