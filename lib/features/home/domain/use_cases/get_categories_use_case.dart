import 'package:commerce_app/core/failure/failure.dart' show Failure;
import 'package:commerce_app/features/home/domain/entities/home_category_entity.dart';
import 'package:commerce_app/features/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategoriesUseCase {
  final HomeRepository homeRepository;

  GetCategoriesUseCase({required this.homeRepository});

  Future<Either<Failure, List<HomeCategoryEntity>>> invoke() =>
      homeRepository.getCategories();
}
