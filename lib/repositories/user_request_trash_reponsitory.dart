import 'package:appwrite/models.dart' as models;
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/providers/category_provider.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
class UserRequestTrashRepository{

  final UserRequestTrashProvider _userRequestTrashProvider;
  UserRequestTrashRepository(this._userRequestTrashProvider);

  // USER
  Future<models.DocumentList> getRequestOfUserFromAppwrite() => _userRequestTrashProvider.getRequestOfUserFromAppwrite();
  Future<models.DocumentList> getRequestWithStatusPending() => _userRequestTrashProvider.getRequestWithStatusPending();
  Future<models.DocumentList> getRequestWithStatusComfirmming() => _userRequestTrashProvider.getRequestWithStatusComfirmming();
  Future<models.DocumentList> getRequestHistory() => _userRequestTrashProvider.getRequestHistory();
  
  Future<void> userRating(String requestId, double? rating) => _userRequestTrashProvider.userRating(requestId, rating);
  
  // COLLECTOR
  Future<models.DocumentList> getRequestListColletor(offset, currentPage) => _userRequestTrashProvider.getRequestListColletor(offset, currentPage);
  Future<int> loadRequestByType(String type,String dateRange) => _userRequestTrashProvider.loadRequestByType(type,dateRange);
  Future<int> loadRequestByDate(String dateRange) => _userRequestTrashProvider.loadRequestByDate(dateRange);
  Future<models.DocumentList> getRequestWithStatusProcessingCollector() => _userRequestTrashProvider.getRequestWithStatusProcessingCollector();
  Future<models.DocumentList> getRequestListConfirmColletor() => _userRequestTrashProvider.getRequestListConfirmColletor();

  Future<void> cancelRequest(String requestId) => _userRequestTrashProvider.cancelRequest(requestId);
  Future<void> hiddenRequest(String requestId, List<String> hidden) => _userRequestTrashProvider.hiddenRequest(requestId,hidden);
  Future<void> confirmRequest(String requestId, String userId) => _userRequestTrashProvider.confirmRequest(requestId,userId);
  Future<void> sendComfirmPhoto(String requestId, String photoConfirm) => _userRequestTrashProvider.sendComfirmPhoto(requestId, photoConfirm);
  Future<models.Document> checkConfirmRequest(String requestId) => _userRequestTrashProvider.checkConfirmRequest(requestId);

  Future<void> sendRequestToAppwrite(UserRequestTrashModel userRequestTrashModel) => _userRequestTrashProvider.sendRequestToAppwrite(userRequestTrashModel);
  Future<models.File> uploadImageToAppwrite(String imagePath) => _userRequestTrashProvider.uploadCategoryImage(imagePath);

  // admin
  Future<models.DocumentList> getRequestByDateRange(String dateRange) => _userRequestTrashProvider.getRequestByDateRange(dateRange);
  Future<String> exportRequestToExcel(models.DocumentList data, String fileName) => _userRequestTrashProvider.exportRequestToExcel(data, fileName);
  // Write function uploadExcelFile
  Future<models.File> uploadExcelFile(String filePath, String nameFile) => _userRequestTrashProvider.uploadExcelFile(filePath, nameFile);
}