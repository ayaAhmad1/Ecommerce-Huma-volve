import 'package:commerce_app/core/failure/failure.dart';
import 'package:commerce_app/features/home/domain/entities/home_category_entity.dart';
import 'package:commerce_app/features/home/domain/entities/home_product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<HomeProductEntity>>> getProducts(
    int? categoryId, {
    required int offset,
    required int limit,
  });
  Future<Either<Failure, List<HomeCategoryEntity>>> getCategories();
  Future<Either<Failure, HomeProductEntity>> getProductById(int productId);
}
