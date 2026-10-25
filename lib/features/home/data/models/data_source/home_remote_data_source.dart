import 'package:commerce_app/features/home/data/models/category_model.dart';
import 'package:commerce_app/features/home/data/models/product_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeProductModel>> getProducts(
    int? categoryId, {
    required int offset,
    required int limit,
  });
  Future<List<HomeCategoryModel>> getCategories();
}
