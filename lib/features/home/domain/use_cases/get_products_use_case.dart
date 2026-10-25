import 'package:commerce_app/core/failure/failure.dart' show Failure;
import 'package:commerce_app/features/home/domain/entities/home_product_entity.dart'
    show HomeProductEntity;
import 'package:dartz/dartz.dart';

import '../repository/home_repository.dart';

class GetProductsUseCase {
  final HomeRepository homeRepository;
  GetProductsUseCase({required this.homeRepository});

  Future<Either<Failure, List<HomeProductEntity>>> invoke(int? categoryId) =>
      homeRepository.getProducts(categoryId);
}
