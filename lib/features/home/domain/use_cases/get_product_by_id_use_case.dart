import 'package:commerce_app/core/failure/failure.dart';
import 'package:commerce_app/features/home/domain/entities/home_product_entity.dart';
import 'package:commerce_app/features/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductByIdUseCase {
  final HomeRepository homeRepository;

  GetProductByIdUseCase({required this.homeRepository});

  Future<Either<Failure, HomeProductEntity>> invoke(int productId) =>
      homeRepository.getProductById(productId);
}
