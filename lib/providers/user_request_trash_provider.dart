import 'dart:async';
import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:thu_gom/models/chart/bar_chart_model.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/services/appwrite.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';

class UserRequestTrashProvider {
  late Account account;
  late Storage storage;
  late Databases databases;
  late Realtime realtime = Realtime(Appwrite.instance.client);

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
        Query.between('status', 'pending', 'processing'),
        Query.equal('senderId', userID),
        Query.orderDesc('createAt')
      ],
    );
    return response;
  }

  // list confirming user
  Future<models.DocumentList> getRequestWithStatusComfirmming() async {
    final GetStorage _getStorage = GetStorage();
    final userID = _getStorage.read('userId');
    final response = await databases!.listDocuments(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      queries: [
        Query.equal('status', 'confirming'),
        Query.equal('senderId', userID),
        Query.orderDesc('updateAt')
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
        Query.between('status', 'cancel', 'finish'),
        Query.equal('senderId', userID),
        Query.orderDesc('updateAt')
      ],
    );
    return response;
  }

  Future<void> userRating(String requestId, double? rating) async {
    await databases?.updateDocument(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      documentId: requestId,
      data: {'rating': rating, 'status': 'finish'},
    );
  }

  // LIST REQUEST OF COLLECTOR
  Future<models.DocumentList> getRequestListColletor(
      int offset, int currentPage) async {
    final response = await databases!.listDocuments(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      queries: [
        Query.equal('status', 'pending'),
        Query.limit(10),
        Query.offset(offset * currentPage),
        Query.orderDesc('createAt')
      ],
    );
    return response;
  }

  Future<models.DocumentList> getRequestWithStatusProcessingCollector() async {
    final GetStorage _getStorage = GetStorage();
    final userID = _getStorage.read('userId');
    final response = await databases!.listDocuments(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      queries: [
        Query.equal('status', 'processing'),
        Query.equal('confirm', userID),
        Query.orderDesc('updateAt')
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
        Query.equal('confirm', userID),
        Query.equal('status', 'finish'),
        Query.orderDesc('updateAt'),
      ],
    );
    return response;
  }

  void getRequestListConfirmColletorRealtime() {
    // final GetStorage _getStorage = GetStorage();
    // final userID = _getStorage.read('userId');
    final subscription = realtime.subscribe(
        ['collections.${AppWriteConstants.userRequestTrashCollection}']);

    subscription.stream.listen((response) {
      print('event: $response');
    });

    // final response = await databases!.listDocuments(
    //   databaseId: AppWriteConstants.databaseId,
    //   collectionId: AppWriteConstants.userRequestTrashCollection,
    //   queries: [
    //     Query.equal('confirm', userID),
    //     Query.equal('status', 'finish')
    //   ],
    // );
    // return response;
  }

  Future<void> sendComfirmInfo(String requestId, String? photoConfirm,
      String? amount_collected, String? collection_price, String? userId, String metal, String paper, String bottle, String hdpe, String nilon, String others) async {
    await databases?.updateDocument(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      documentId: requestId,
      data: {
        'finishImage': photoConfirm,
        'amount_collected': amount_collected,
        'collection_price': collection_price,
        'status': 'confirming',
        'metal': metal,
        'paper': paper,
        'bottle': bottle,
        'hdpe': hdpe,
        'nilon': nilon,
        'others': others,
      },
    );
    if(userId != null){
      //Xóa request process của user
      await databases.updateDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.usersCollection,
        documentId: userId,
        data: {
          'requestProcess': '',
        },
      );
    }
  }
  Future<void> updateAvatarCollector(String requestId, String? imageLink) async {
    await databases?.updateDocument(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.usersCollection,
      documentId: requestId,
      data: {
        'avatar': imageLink
      },
    );
  }

  Future<void> cancelRequest(String requestId) async {
    await databases?.updateDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.userRequestTrashCollection,
        documentId: requestId,
        data: {
          'status': 'cancel',
        });
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
    await databases.updateDocument(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      documentId: requestId,
      data: {'confirm': userId, 'status': 'processing'},
    );
    await databases.updateDocument(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.usersCollection,
      documentId: userId,
      data: {'requestProcess': requestId},
    );
  }

  Future<models.Document> checkConfirmRequest(String requestId) async {
    final result = await databases.getDocument(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      documentId: requestId,
    );
    return result;
  }

  Future<models.Document> checkRequestProcess(String userId) async {
    final result = await databases.getDocument(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.usersCollection,
      documentId: userId,
    );
    return result;
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
            "metal": userRequestTrashModel.metal,
            "paper": userRequestTrashModel.paper,
            "bottle": userRequestTrashModel.bottle,
            "hdpe": userRequestTrashModel.hdpe,
            "nilon": userRequestTrashModel.nilon,
            "others": userRequestTrashModel.others,
            "amount_collected": userRequestTrashModel.amount_collected,
          });
      print("sendRequestToAppwrite");
    } catch (e) {
      print("sendRequestToAppwrite error: $e");
    }
  }

  Future sendFeedbackToAppwrite(
      UserRequestTrashModel userRequestTrashModel) async {
    try {
      await databases.createDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.userFeedbackTrashCollection,
          documentId: userRequestTrashModel.requestId,
          data: {
            "senderId": userRequestTrashModel.senderId,
            "image": userRequestTrashModel.image,
            "phone_number": userRequestTrashModel.phone_number,
            "address": userRequestTrashModel.address,
            "description": userRequestTrashModel.description,
            "point_lat": userRequestTrashModel.point_lat,
            "point_lng": userRequestTrashModel.point_lng,
            "createAt": userRequestTrashModel.createAt,
          });
    } catch (e) {
      print("sendFeedbackToAppwrite error: $e");
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

  Future<int> loadRequestByType(String type, String dateRange) async {
    List<String> dates = dateRange.toString().split(" - ");
    print(dates[0]);
    print(dates[1]);
    final response = await databases.listDocuments(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      queries: [
        Query.equal('trash_type', type),
        Query.greaterThanEqual('createAt', dates[0]),
        Query.lessThanEqual('createAt', dates[1]),
        Query.limit(100000),
      ],
    );
    return response.total;
  }

  Future<int> loadRequestPending( String dateRange) async {
    List<String> dates = dateRange.toString().split(" - ");
    print(dates[0]);
    print(dates[1]);
    final response = await databases.listDocuments(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      queries: [
        Query.equal('status', 'pending'),
        Query.greaterThanEqual('createAt', dates[0]),
        Query.lessThanEqual('createAt', dates[1]),
         Query.limit(100000),
      ],
    );
    return response.total;
  }

  Future<models.DocumentList> getRequestByDateRange(String dateRange) async {
    List<String> dates = dateRange.toString().split(" - ");
    final response = await databases.listDocuments(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      queries: [
        Query.greaterThanEqual('createAt', dates[0]),
        Query.lessThanEqual('createAt', dates[1]),
        Query.limit(100000),
      ],

    );
    return response;
  }

  Future<String> exportRequestToExcel(
      models.DocumentList data, String fileName) async {
    final stopwatch = Stopwatch()..start();

    final excel = Excel.createExcel();
    final Sheet sheet = excel[excel.getDefaultSheet()!];

    //   // Write header row
    sheet.appendRow([
      TextCellValue('Mã người gửi'),
      TextCellValue('Hình ảnh'),
      TextCellValue('Số điện thoại'),
      TextCellValue('Địa chỉ'),
      TextCellValue('Mô tả'),
      TextCellValue('Trạng thái'),
      TextCellValue('Xác nhận'),
      TextCellValue('Ẩn'),
      TextCellValue('Loại rác'),
      TextCellValue('thời gian tạo'),
      TextCellValue('thời gian cập nhật'),
      TextCellValue('Vĩ độ'),
      TextCellValue('Kinh độ'),
      TextCellValue('Hình ảnh minh chứng'),
      TextCellValue('Đánh giá'),
      TextCellValue('Giá thu gom(vnd)'),
      TextCellValue('Số lượng thu gom(kg)'),
      TextCellValue("Kim loại"),
      TextCellValue("Giấy"),
      TextCellValue("Chai"),
      TextCellValue("HDPE"),
      TextCellValue("Nilon"),
      TextCellValue("Khác"),
    ]);
    sheet.appendRow([]);

    // Populate data
    for (final document in data.documents) {
      sheet.appendRow([
        TextCellValue(document.data['senderId'] ?? ''),
        TextCellValue(document.data['image'] ?? ''),
        TextCellValue(document.data['phone_number'] ?? ''),
        TextCellValue(document.data['address'] ?? ''),
        TextCellValue(document.data['description'] ?? ''),
        TextCellValue(document.data['status'] ?? ''),
        TextCellValue(document.data['confirm'] ?? ''),
        TextCellValue(document.data['hidden'].toString()),
        TextCellValue(document.data['trash_type'] ?? ''),
        TextCellValue(document.data['createAt'] ?? ''),
        TextCellValue(document.data['updateAt'] ?? ''),
        TextCellValue(document.data['point_lat'].toString()),
        TextCellValue(document.data['point_lng'].toString()),
        TextCellValue(document.data['finishImage'] ?? ''),
        TextCellValue(document.data['rating'].toString()),
        TextCellValue(document.data['collection_price'].toString()),
        TextCellValue(document.data['amount_collected'].toString()),
        TextCellValue(document.data['metal'].toString()),
        TextCellValue(document.data['paper'].toString()),
        TextCellValue(document.data['bottle'].toString()),
        TextCellValue(document.data['hdpe'].toString()),
        TextCellValue(document.data['nilon'].toString()),
        TextCellValue(document.data['others'].toString()),
      ]);

      // break line
      sheet.appendRow([]);
    }

    final fileBytes = excel.save() as List<int>;
    // upload file to appwrite
    final uploadedFile = await uploadExcelFileToAppwrite(fileBytes, fileName);

    return uploadedFile.$id;
  }

  Future<models.File> uploadExcelFileToAppwrite(
      List<int> fileBytes, String fileName) async {
    // Append .xlsx extension to the file name
    final excelFileName = fileName + '.xlsx';

    // Convert Uint8List to InputFile
    final excelFile = InputFile.fromBytes(
      bytes: fileBytes,
      filename: excelFileName,
      // contentType: 'application/vnd.ms-excel',
    );

    // Upload file to Appwrite
    final response = await storage.createFile(
      bucketId: AppWriteConstants.analysisExcelBucketId,
      fileId: ID.unique(),
      file: excelFile,
    );
    return response;
  }

  Future<models.File> uploadExcelFile(String imagePath, String fileName) {
    final response = storage.createFile(
      bucketId: AppWriteConstants.analysisExcelBucketId,
      fileId: ID.unique(),
      file: InputFile.fromPath(path: imagePath, filename: fileName),
    );
    return response;
  }

  Future<int> loadRequestByDate(String dateRange) async {
    String startDate = dateRange + " 00:00:00.000";
    String endDate = dateRange + " 24:59:59.000";
    final response = await databases!.listDocuments(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      queries: [
        Query.greaterThanEqual('createAt', startDate),
        Query.lessThanEqual('createAt', endDate),
        Query.limit(100000),
      ],
    );
    return response.total;
  }

  Future<int> loadRequestPendingByDate(String dateRange) async {
    String startDate = dateRange + " 00:00:00.000";
    String endDate = dateRange + " 23:59:59.000";
    final response = await databases!.listDocuments(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.userRequestTrashCollection,
      queries: [
        Query.equal('status', 'pending'),
        Query.greaterThanEqual('createAt', startDate),
        Query.lessThanEqual('createAt', endDate),
        Query.limit(100000),
      ],
    );
    return response.total;
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
