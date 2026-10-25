import 'package:commerce_app/core/error/error_handling.dart';
import 'package:commerce_app/core/failure/failure.dart';
import 'package:commerce_app/features/home/data/models/data_source/home_remote_data_source.dart';
import 'package:commerce_app/features/home/domain/entities/home_category_entity.dart';
import 'package:commerce_app/features/home/domain/entities/home_product_entity.dart';
import 'package:commerce_app/features/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImplement implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImplement(this.homeRemoteDataSource);

  @override
  Future<Either<Failure, List<HomeCategoryEntity>>> getCategories() async {
    try {
      final categories = await homeRemoteDataSource.getCategories();
      return Right(categories as List<HomeCategoryEntity>);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<HomeProductEntity>>> getProducts(
    int? categoryId, {
    required int offset,
    required int limit,
  }) async {
    try {
      final products = await homeRemoteDataSource.getProducts(
        categoryId,
        offset: offset,
        limit: limit,
      );
      return Right(products as List<HomeProductEntity>);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
