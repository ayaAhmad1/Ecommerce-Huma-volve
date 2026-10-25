import 'package:commerce_app/features/home/domain/entities/home_category_entity.dart';
import 'package:commerce_app/features/home/domain/entities/home_product_entity.dart';

abstract class HomeStates {
  const HomeStates();
}

class HomeInitial extends HomeStates {
  const HomeInitial();
}

class HomeDataState extends HomeStates {
  final List<HomeCategoryEntity> categories;
  final List<HomeProductEntity> products;
  final bool categoriesLoading;
  final bool productsLoading;
  final String? categoriesError;
  final String? productsError;

  const HomeDataState({
    this.categories = const [],
    this.products = const [],
    this.categoriesLoading = false,
    this.productsLoading = false,
    this.categoriesError,
    this.productsError,
  });

  HomeDataState copyWith({
    List<HomeCategoryEntity>? categories,
    List<HomeProductEntity>? products,
    bool? categoriesLoading,
    bool? productsLoading,
    String? categoriesError,
    String? productsError,
    bool clearCategoriesError = false,
    bool clearProductsError = false,
  }) {
    return HomeDataState(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      categoriesLoading: categoriesLoading ?? this.categoriesLoading,
      productsLoading: productsLoading ?? this.productsLoading,
      categoriesError: clearCategoriesError
          ? null
          : categoriesError ?? this.categoriesError,
      productsError: clearProductsError
          ? null
          : productsError ?? this.productsError,
    );
  }
}
