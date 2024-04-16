import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String email;
  final String username;
  final String name;
  final String role;
  final String uid;
  final String phonenumber;
  final String zalonumber;
  final String address;
  final String? avatar;
  const UserModel({
    required this.email,
    required this.username,
    required this.name,
    required this.role,
    required this.uid,
    required this.phonenumber,
    required this.zalonumber,
    required this.address,
    this.avatar,
  });

  UserModel copyWith({
    String? email,
    String? username,
    String? name,
    String? role,
    String? uid,
    String? phonenumber,
    String? zalonumber,
    String? address,
    String? avatar,
  }) {
    return UserModel(
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      role: role ?? this.role,
      uid: uid ?? this.uid,
      phonenumber: phonenumber ?? this.phonenumber,
      zalonumber: zalonumber ?? this.zalonumber,
      address: address ?? this.address,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'name': name,
      'role': role,
      'uid': uid,
      'phonenumber': phonenumber,
      'zalonumber': zalonumber,
      'address': address,
      'avatar': avatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      role: map['role'] ?? '',
      uid: map['uid'] ?? '',
      phonenumber: map['phonenumber'] ?? '',
      zalonumber: map['zalonumber'] ?? '',
      address: map['address'] ?? '',
      avatar: map['avatar'] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserModel(email: $email, username: $username, name: $name, role: $role, uid: $uid, phonenumber: $phonenumber, zalonumber: $zalonumber, address: $address, avatar: $avatar,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.email == email &&
        other.username == username &&
        other.name == name &&
        other.role == role &&
        other.uid == uid &&
        other.phonenumber == phonenumber &&
        other.zalonumber == zalonumber &&
        other.address == address &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return email.hashCode ^
    username.hashCode ^
    name.hashCode ^
    role.hashCode ^
    uid.hashCode ^
    phonenumber.hashCode ^
    zalonumber.hashCode ^
    address.hashCode ^
    avatar.hashCode;
  }
}

