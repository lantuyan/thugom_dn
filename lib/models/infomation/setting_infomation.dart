class SettingInformation {
  late String title;
  String? description;
  late String imageLink;
  late String link;

  SettingInformation({
    required this.title,
    this.description,
    required this.imageLink,
    required this.link,
  });

  SettingInformation.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    description = map['description'];
    imageLink = map['imagelink'];
    link = map['link'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imagelink': imageLink,
      'link': link,
    };
  }
}