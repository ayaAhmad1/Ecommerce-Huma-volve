import 'package:commerce_app/features/home/domain/entities/home_product_entity.dart';
import 'package:commerce_app/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:commerce_app/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:commerce_app/features/home/presentation/view_model/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  final int limit = 10;
  int offset = 0;

  bool isLoadingMore = false;
  bool hasMore = true;
  int? selectedCategory;
  final List<HomeProductEntity> _products = [];

  HomeCubit({
    required this.getProductsUseCase,
    required this.getCategoriesUseCase,
  }) : super(const HomeInitial());

  Future<void> loadHomeData() async {
    emit(CategoriesLoading());

    final categoriesResult = await getCategoriesUseCase.invoke();

    final categories = categoriesResult.fold(
      (failure) {
        emit(CategoriesError(failure.failureMessage));
        return null;
      },
      (categories) {
        emit(CategoriesSuccess(categories));
        return categories;
      },
    );

    if (categories == null || categories.isEmpty) return;

    await getProductsByCategoryId(categories.first.id);
  }

  Future<void> getProductsByCategoryId(int id) async {
    selectedCategory = id;
    offset = 0;
    hasMore = true;
    isLoadingMore = false;
    _products.clear();

    emit(ProductsLoading());

    final result = await getProductsUseCase.invoke(
      id,
      limit: limit,
      offset: offset,
    );

    result.fold(
      (failure) {
        emit(ProductsError(failure.failureMessage));
      },
      (products) {
        _products.addAll(products);
        offset = products.length;
        hasMore = products.length >= limit;

        emit(ProductsSuccess(List.from(_products)));
      },
    );
  }

  Future<void> loadMoreProducts() async {
    final categoryId = selectedCategory;

    if (categoryId == null || isLoadingMore || !hasMore) return;

    isLoadingMore = true;
    emit(ProductsLoadingMore());

    try {
      final result = await getProductsUseCase.invoke(
        categoryId,
        limit: limit,
        offset: offset,
      );

      result.fold(
        (failure) {
          emit(ProductsLoadingError(errorMessage: failure.failureMessage));
        },
        (newProducts) {
          _products.addAll(newProducts);
          offset += newProducts.length;
          hasMore = newProducts.length >= limit;

          emit(ProductsSuccess(List.from(_products)));
        },
      );
    } finally {
      isLoadingMore = false;
    }
  }
}
