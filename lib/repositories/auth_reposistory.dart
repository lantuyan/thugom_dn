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
  Future<bool> checkUserExist(String phonenumber) => _authProvider.checkUserExist(phonenumber);
  Future<bool> checkUserBlackList(String userId) => _authProvider.checkUserBlacklist(userId);
  Future<String?> registerOrLoginWithPhoneNumber(String phoneNumber) => _authProvider.registerOrLoginWithPhoneNumber(phoneNumber);
  Future<models.Session> phoneConfirm(String pinCode,String userId) => _authProvider.phoneConfirm(pinCode,userId);
  Future<void> registerWithPhone(Map data) => _authProvider.registerWithPhone(data);
  Future<void> updateProfile(Map map,String address,String userId, String avatar) => _authProvider.updateProfile(map,address,userId, avatar);
  Future<void> logOut(String sessionId) => _authProvider.logOut(sessionId);
  Future<models.Session> getCurrentSession() => _authProvider.getCurrentSession();

  Future verifyEmail() => _authProvider.verifyEmail();

  Future sendLinkResetPassword(Map map) => _authProvider.sendLinkResetPassword(map);
  Future resetPassword(Map map, String userId, String secret ) => _authProvider.resetPassword(map, userId, secret);

  
}