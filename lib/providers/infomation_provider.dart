
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:thu_gom/services/appwrite.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';

class InfomationProvider {
  Account? account;
  Storage? storage;
  Databases? databases;

  InfomationProvider() {
    account = Account(Appwrite.instance.client);
    storage = Storage(Appwrite.instance.client);
    databases = Databases(Appwrite.instance.client);
  }

  
    Future<models.Document> getMainInfomationSetting() async {
      final response = await databases!.getDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.settingInformationCollection,
          documentId: "main_infomation"
      );
      return response;

  }

  Future<models.DocumentList> getCategoryPrice() async {
    final response = await databases!.listDocuments(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.categoryPriceCollectionId
    );
    return response;
  }

}
