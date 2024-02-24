import 'dart:typed_data';

class ScanModel {
  final String id;
  final String uid;
  final Uint8List image;
  final String label;
  final String location;
  final DateTime time;

  const ScanModel({
    required this.id,
    required this.uid,
    required this.image,
    required this.label,
    required this.location,
    required this.time,
  });

  ScanModel copyWith({
    String? id,
    String? uid,
    Uint8List? image,
    String? label,
    String? location,
    DateTime? time,
  }) {
    return ScanModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      image: image ?? this.image,
      label: label ?? this.label,
      location: location ?? this.location,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'image': image,
      'label': label,
      'location': location,
      'time': time.toIso8601String(),
    };
  }

  factory ScanModel.fromMap(Map<String, dynamic> map) {
    return ScanModel(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      image: map['image'] ?? '',
      label: map['label'] ?? '',
      location: map['location'] ?? '',
      time: DateTime.parse(map['time'] ?? ''),
    );
  }

  @override
  String toString() {
    return 'ScanModel(id: $id, uid: $uid, image: $image, label: $label, location: $location, time: $time)';
  }
}
