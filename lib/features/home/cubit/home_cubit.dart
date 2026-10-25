import 'package:commerce_app/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:commerce_app/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:commerce_app/features/home/presentation/view_model/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
  }) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeDataState(categoriesLoading: true, productsLoading: true));

    final result = await getCategoriesUseCase.invoke();
    await result.fold(
      (failure) {
        emit(
          HomeDataState(
            categoriesLoading: false,
            productsLoading: false,
            categoriesError: failure.failureMessage,
          ),
        );
      },
      (categories) async {
        if (categories.isEmpty) {
          emit(
            HomeDataState(
              categories: categories,
              categoriesLoading: false,
              productsLoading: false,
            ),
          );
          return;
        }

        emit(
          HomeDataState(
            categories: categories,
            categoriesLoading: false,
            productsLoading: true,
          ),
        );
        await loadProductsByCategory(categories.first.id);
      },
    );
  }

  Future<void> loadProductsByCategory(int id) async {
    final current = state;
    final currentData = current is HomeDataState ? current : HomeDataState();
    emit(currentData.copyWith(productsLoading: true, clearProductsError: true));

    final result = await getProductsUseCase.invoke(id);
    result.fold(
      (failure) {
        emit(
          currentData.copyWith(
            productsLoading: false,
            productsError: failure.failureMessage,
          ),
        );
      },
      (products) {
        emit(
          currentData.copyWith(
            products: products,
            productsLoading: false,
            clearProductsError: true,
          ),
        );
      },
    );
  }

  Future<void> getProductsByCategoryId(int id) => loadProductsByCategory(id);
}
