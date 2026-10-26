import 'package:commerce_app/core/network/api_client.dart';
import 'package:commerce_app/core/failure/failure.dart';
import 'package:commerce_app/features/details/screens/product_details_screen.dart';
import 'package:commerce_app/features/home/data/models/data_source/home_remote_data_source_implement.dart';
import 'package:commerce_app/features/home/data/repository/home_repository_implement.dart';
import 'package:commerce_app/features/home/domain/entities/home_product_entity.dart';
import 'package:commerce_app/features/home/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/material.dart';

class SharedProductScreen extends StatefulWidget {
  final String productId;

  const SharedProductScreen({super.key, required this.productId});

  @override
  State<SharedProductScreen> createState() => _SharedProductScreenState();
}

class _SharedProductScreenState extends State<SharedProductScreen> {
  late final Future<Either<Failure, HomeProductEntity>> _productFuture;

  @override
  void initState() {
    super.initState();
    final productId = int.tryParse(widget.productId);
    if (productId == null) {
      _productFuture = Future<Either<Failure, HomeProductEntity>>.error(
        const FormatException('Invalid product ID'),
      );
      return;
    }

    final apiClient = ApiClient();
    final remoteDataSource = HomeRemoteDataSourceImplement(
      apiClient: apiClient,
    );
    final repository = HomeRepositoryImplement(remoteDataSource);
    _productFuture = GetProductByIdUseCase(
      homeRepository: repository,
    ).invoke(productId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<Failure, HomeProductEntity>>(
      future: _productFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _ProductLoadError(message: 'Invalid product link.');
        }
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final result = snapshot.data!;
        return result.fold(
          (failure) => _ProductLoadError(message: failure.failureMessage),
          (product) => ProductDetailsScreen(product: product),
        );
      },
    );
  }
}

class _ProductLoadError extends StatelessWidget {
  final String message;

  const _ProductLoadError({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(message, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
