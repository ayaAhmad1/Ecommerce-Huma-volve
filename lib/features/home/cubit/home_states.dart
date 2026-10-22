import 'package:commerce_app/features/home/services/models/category_model.dart';
import 'package:commerce_app/features/home/services/models/product_model.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeDataState extends HomeStates {
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  final bool categoriesLoading;
  final bool productsLoading;
  final String? categoriesError;
  final String? productsError;

  HomeDataState({
    this.categories = const [],
    this.products = const [],
    this.categoriesLoading = false,
    this.productsLoading = false,
    this.categoriesError,
    this.productsError,
  });

  HomeDataState copyWith({
    List<CategoryModel>? categories,
    List<ProductModel>? products,
    bool? categoriesLoading,
    bool? productsLoading,
    String? categoriesError,
    String? productsError,
    bool clearProductsError = false,
    bool clearCategoriesError = false,
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
