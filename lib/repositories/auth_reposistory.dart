import 'package:thu_gom/models/user/user_model.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:appwrite/models.dart' as models;

class AuthRepository{
  final AuthProvider _authProvider;
  AuthRepository(this._authProvider);
  Future<models.Session> login(Map map) => _authProvider.login(map);
  Future<UserModel> getUserModel(String userId) => _authProvider.getUserModel(userId);
  Future<models.User> register(Map map,String role) => _authProvider.register(map,role);
  Future<void> loginOAuth2(String provider) => _authProvider.loginOAuth2(provider);
  // Future<String?> loginWithPhoneNumber(String phoneNumber) => _authProvider.loginWithPhoneNumber(phoneNumber);
  // Future<models.Session> phoneConfirm(String pinCode,String userId,String name) => _authProvider.phoneConfirm(pinCode,userId, name);
  // Future<void> updateUserInfo(String userId,String name) => _authProvider.updateUserInfo(userId,name);
  Future<void> logOut(String sessionId) => _authProvider.logOut(sessionId);
  Future<models.Session> getCurrentSession() => _authProvider.getCurrentSession();


  Future verifyEmail() => _authProvider.verifyEmail();

  Future sendLinkResetPassword(Map map) => _authProvider.sendLinkResetPassword(map);
  Future resetPassword(Map map, String userId, String secret ) => _authProvider.resetPassword(map, userId, secret);

  
}