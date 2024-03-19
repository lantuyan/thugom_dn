class CategoryPriceModel {
  late String name;
  late String price;

  CategoryPriceModel({required this.name, required this.price});

  CategoryPriceModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    price = map['price'];
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price};
  }
}
