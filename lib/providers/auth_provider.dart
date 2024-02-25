import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:thu_gom/models/user/user_model.dart';
import 'package:thu_gom/services/appwrite.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';
import 'package:uuid/uuid.dart';


class AuthProvider {
  late Account account;
  late Databases _db;

  AuthProvider() {
    account = Account(Appwrite.instance.client);
    _db = Databases(Appwrite.instance.client);
  }

  Future<models.Session> login(Map map) {
    final response = account.createEmailSession(
        email: map['email'], password: map['password']);
    return response;
  }
  Future<UserModel> getUserModel(String userId) async {
    // Gọi API để lấy dữ liệu từ Database Appwrite
    final response = await _db.getDocument(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.usersCollection,
      documentId: userId,
    );

    // Xây dựng UserModel từ dữ liệu nhận được
    final userModel = UserModel.fromMap(response.data);
    return userModel;
  }
  // Register
  Future<models.User> register(Map map,String role) async {
    final response =  await account.create(
      userId: ID.unique(),
      email: map['email'],
      password: map['password'],
      name: map['name'],
    );
    UserModel userModel = UserModel(
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      role: role,
      uid: response.$id,
      phonenumber: map['phonenumber'] ?? '',
      zalonumber: map['zalonumber'] ?? '',
      address: map['address'] ?? '',
    );

    try {
      await _db.createDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.usersCollection,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );
    } catch (e) {
      print(e);
    }
    // await saveUserData(userModel);
    // res2.fold((l) => print(l), (r) => print(r));
    return response;
  }

  // Future<models.User> registera(String email, String password, String name) async {
  //   final response = await account.create(
  //       userId: ID.unique(), email: email, password: password, name: name);
  //   return response;
  // }

  Future<void> loginOAuth2(String provider) async {
    await account.createOAuth2Session(provider: provider);
  }

  Future<String?> loginWithPhoneNumber(String phoneNumber) async {
    String? userId;
    try {
      // Tạo phiên đăng nhập bằng điện thoại và nhận userId từ hàm createPhoneSession
      var session = await account.createPhoneSession(userId: ID.unique(), phone: phoneNumber);
      userId = session.userId;
    } catch (e) {
      print(e);
    }
    return userId;
  }


  Future<models.Session> phoneConfirm(String pinCode,String userId,String name) async {
    final phoneSession = await account.updatePhoneSession(
      userId: userId,
      secret: pinCode,
    );
    // update name
    await account.updateName(name: name,);

    return phoneSession;
  }
  // Future<void> updateUserInfo(String userId,String name) async {
  //   // Create document to storage user info
  //   UserModel userModel = UserModel(
  //     email: 'unknown',
  //     name: name,
  //     uid: userId,
  //     profilePic: '',
  //     bio: '',
  //     scans: [],
  //   );
  //   await _db.createDocument(
  //     databaseId: AppWriteConstants.databaseId,
  //     collectionId: AppWriteConstants.usersCollection,
  //     documentId: userModel.uid,
  //     data: userModel.toMap(),
  //   );
  // }
  Future<void> logOut(String sessionId) {
    return account.deleteSession(sessionId: sessionId);
  }

  Future<models.Session> getCurrentSession() {
    return account.getSession(sessionId: 'current');
  }

  Future resetPassword(
      Map map, String userId, String secret) async {
    try {
      await account.updateRecovery(
      userId: userId,
      secret: secret,
      password: map['password'],
      passwordAgain: map['password'],
    );
      return null;
    } on AppwriteException catch (e) {
      print(e);
    }
  }

  Future sendLinkResetPassword(Map map) async {
    final response = await account.createRecovery(
        email: map['email'],
        url: "https://reset-password-alpha.vercel.app/reset-password");
    return response;
  }

  //DONE VERIFICATION EMAIL:
  Future validateEmail(String userID, String secret) async {
    try {
      await account.updateVerification(userId: userID, secret: secret);
      return null;
    } on AppwriteException catch (e) {
      print(e);
    }
  }

  Future verifyEmail() async {
    final response = await account.createVerification(
        url: "https://reset-password-alpha.vercel.app");
    return response;
  }

  // GET USERNAME
  Future<models.User> getUser() async {
    // Fetch user data
    final user = await account.get();
    return user;
  }

  Future saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.usersCollection,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );
      print('User data saved');
    } catch (e) {
      print(e);
    }
  }
}
