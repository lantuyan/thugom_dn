import 'package:appwrite/models.dart' as models;
import 'package:thu_gom/providers/category_provider.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
class UserRequestTrashRepository{

  final UserRequestTrashProvider _userRequestTrashProvider;
  UserRequestTrashRepository(this._userRequestTrashProvider);


  Future<models.DocumentList> getRequestOfUserFromAppwrite() => _userRequestTrashProvider.getRequestOfUserFromAppwrite();
  Future<models.DocumentList> getRequestWithStatusPending() => _userRequestTrashProvider.getRequestWithStatusPending();
  Future<models.DocumentList> getRequestHistory() => _userRequestTrashProvider.getRequestHistory();

  Future<void> cancelRequest(String requestId) => _userRequestTrashProvider.cancelRequest(requestId);
  Future<void> hiddenRequest(String requestId, List<String> hidden) => _userRequestTrashProvider.hiddenRequest(requestId,hidden);
  Future<void> confirmRequest(String requestId, String userId) => _userRequestTrashProvider.confirmRequest(requestId,userId);

}