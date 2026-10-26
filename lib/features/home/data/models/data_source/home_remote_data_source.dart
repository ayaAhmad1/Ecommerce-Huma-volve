import 'package:commerce_app/features/home/data/models/category_model.dart';
import 'package:commerce_app/features/home/data/models/product_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeProductModel>> getProducts(
    int? categoryId, {
    required int limit,
    required int offset,
  });
  Future<List<HomeCategoryModel>> getCategories();
  Future<HomeProductModel> getProductById(int productId);
}
