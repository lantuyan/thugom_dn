import 'package:appwrite/models.dart' as models;
import 'package:thu_gom/providers/category_provider.dart';
class CategoryRepository{

  final CategoryProvider _categoryProvider;
  CategoryRepository(this._categoryProvider);


  Future<models.DocumentList> getCategory() => _categoryProvider.getCategory();
  Future<models.DocumentList> getCategoryPrice() => _categoryProvider.getCategoryPrice();

  // Future<models.File> uploadCategoryImage(String imagePath) => _categoryProvider.uploadCategoryImage(imagePath);
  // Future<dynamic> deleteCategoryImage(String fileId) => _categoryProvider.deleteCategoryImage(fileId);
  // Future<models.Document> createCategory(Map map) => _categoryProvider.createCategory(map);
  // Future<models.DocumentList> getCategoryDetail() => _categoryProvider.getCategoryDetail();


}