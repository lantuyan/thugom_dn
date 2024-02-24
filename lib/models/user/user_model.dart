import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String email;
  final String name;
  final List<String> scans;
  final String profilePic;
  final String uid;
  final String bio;
  const UserModel({
    required this.email,
    required this.name,
    required this.scans,
    required this.profilePic,
    required this.uid,
    required this.bio,
  });

  UserModel copyWith({
    String? email,
    String? name,
    List<String>? scans,
    String? profilePic,
    String? uid,
    String? bio,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      scans: scans ?? this.scans,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'name': name});
    result.addAll({'scans': scans});
    result.addAll({'profilePic': profilePic});
    result.addAll({'bio': bio});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      scans: List<String>.from(map['scans']),
      profilePic: map['profilePic'] ?? '',
      uid: map['\$id'] ?? '',
      bio: map['bio'] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, scans: $scans, profilePic: $profilePic, uid: $uid, bio: $bio)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.email == email &&
        other.name == name &&
        listEquals(other.scans, scans) &&
        other.profilePic == profilePic &&
        other.uid == uid &&
        other.bio == bio;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        scans.hashCode ^
        profilePic.hashCode ^
        uid.hashCode ^
        bio.hashCode;
  }
}
