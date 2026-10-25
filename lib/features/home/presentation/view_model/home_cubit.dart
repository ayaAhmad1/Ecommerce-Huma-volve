import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_categories_use_case.dart';
import '../../domain/use_cases/get_products_use_case.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
  }) : super(const HomeInitial());

  Future<void> loadHomeData() async {
    emit(const HomeDataState(categoriesLoading: true, productsLoading: true));

    final categoriesResult = await getCategoriesUseCase.invoke();

    await categoriesResult.fold(
      (failure) async {
        emit(
          HomeDataState(
            categoriesLoading: false,
            productsLoading: false,
            categoriesError: failure.failureMessage,
          ),
        );
      },
      (categories) async {
        emit(
          HomeDataState(
            categories: categories,
            categoriesLoading: false,
            productsLoading: categories.isNotEmpty,
          ),
        );

        if (categories.isNotEmpty) {
          await loadProductsByCategory(categories.first.id);
        }
      },
    );
  }

  Future<void> loadProductsByCategory(int id) async {
    final current = state;

    if (current is! HomeDataState) return;

    emit(current.copyWith(productsLoading: true, clearProductsError: true));

    final productsResult = await getProductsUseCase.invoke(id);

    productsResult.fold(
      (failure) {
        emit(
          (state as HomeDataState).copyWith(
            productsLoading: false,
            productsError: failure.failureMessage,
          ),
        );
      },
      (products) {
        emit(
          (state as HomeDataState).copyWith(
            products: products,
            productsLoading: false,
            clearProductsError: true,
          ),
        );
      },
    );
  }
}
