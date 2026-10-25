import 'package:commerce_app/features/home/domain/entities/home_category_entity.dart';
import 'package:commerce_app/features/home/domain/entities/home_product_entity.dart';

abstract class HomeStates {
  const HomeStates();
}

class HomeInitial extends HomeStates {
  const HomeInitial();
}

class CategoriesLoading extends HomeStates {}

class CategoriesSuccess extends HomeStates {
  final List<HomeCategoryEntity> categories;
  CategoriesSuccess(this.categories);
}

class CategoriesError extends HomeStates {
  final String failureMessage;
  CategoriesError(this.failureMessage);
}

class ProductsLoading extends HomeStates {}

class ProductsSuccess extends HomeStates {
  final List<HomeProductEntity> products;
  ProductsSuccess(this.products);
}

class ProductsError extends HomeStates {
  final String failureMessage;
  ProductsError(this.failureMessage);
}

class ProductsLoadingMore extends HomeStates {}

class ProductsLoadingError extends HomeStates {
  final String errorMessage;

  ProductsLoadingError({required this.errorMessage});
}
