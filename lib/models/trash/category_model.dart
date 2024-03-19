class CategoryModel {
  late String categoryID;
  late String category_title;
  late String category_description;
  late String category_image;
  late List? categoryPrice;

  CategoryModel(
      {required this.categoryID,
      required this.category_title,
      required this.category_description,
      required this.category_image,
      this.categoryPrice});

  CategoryModel.fromMap(Map<String, dynamic> map) {
    categoryID = map['\$id'];
    category_title = map['title'];
    category_description = map['description'];
    category_image = map['image'];
    if (map['categoryPrice'] != null) {
      categoryPrice = List<dynamic>.from(map['categoryPrice']);
    } else {
      categoryPrice = [];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      '\$id': categoryID,
      'title': category_title,
      'description': category_description,
      'image': category_image,
      'categoryPrice': categoryPrice,
    };
  }
}
