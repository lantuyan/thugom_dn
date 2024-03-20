class UserRequestTrashModel {
  late String requestId;
  late String senderId;
  late String trash_type;
  late String image;
  late String phone_number;
  late String address;
  late String description;
  late double point_lat;
  late double point_lng;
  late String status;
  late String? confirm;
  late List<String>? hidden;
  late String createAt;
  late String updateAt;
  late double? rating;
  late String? finishImage;
  UserRequestTrashModel(
      {required this.requestId,
      required this.senderId,
      required this.trash_type,
      required this.image,
      required this.phone_number,
      required this.address,
      required this.description,
      required this.point_lat,
      required this.point_lng,
      required this.status,
      this.confirm,
      this.hidden,
      required this.createAt,
      required this.updateAt,
      this.rating,
      this.finishImage});

  UserRequestTrashModel.fromMap(Map<String, dynamic> map) {
    requestId = map['\$id'];
    senderId = map['senderId'];
    trash_type = map['trash_type'];
    image = map['image'];
    phone_number = map['phone_number'];
    address = map['address'];
    description = map['description'];
    point_lat = map['point_lat'].toDouble();
    point_lng = map['point_lng'].toDouble();
    status = map['status'];
    confirm = map['confirm'];
    if (map['hidden'] != null) {
      hidden = List<String>.from(map['hidden']);
    } else {
      hidden = [];
    }
    createAt = map['createAt'];
    updateAt = map['updateAt'];
    rating = map['rating'];
    finishImage = map['finishImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      '\$id': requestId,
      'senderId': senderId,
      'trash_type': trash_type,
      'image': image,
      'phone_number': phone_number,
      'address': address,
      'description': description,
      'point_lat': point_lat,
      'point_lng': point_lng,
      'status': status,
      'confirm': confirm,
      'hidden': hidden,
      'createAt': createAt,
      'updateAt': updateAt,
      'rating': rating,
      'finishImage': finishImage,
    };
  }
}
