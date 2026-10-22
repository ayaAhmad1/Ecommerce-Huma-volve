import 'package:commerce_app/features/home/cubit/home_states.dart';
import 'package:commerce_app/features/home/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeServices homeServices;

  HomeCubit(this.homeServices) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeDataState(categoriesLoading: true, productsLoading: true));

    try {
      final categories = await homeServices.categories();

      emit(
        HomeDataState(
          categories: categories,
          categoriesLoading: false,
          productsLoading: true,
        ),
      );

      if (categories.isEmpty) {
        emit(HomeDataState(categories: categories, productsLoading: false));
        return;
      }

      await loadProductsByCategory(categories.first.id);
    } catch (e) {
      emit(
        HomeDataState(
          categoriesLoading: false,
          productsLoading: false,
          categoriesError: e.toString(),
        ),
      );
    }
  }

  Future<void> loadProductsByCategory(dynamic categoryId) async {
    final current = state;

    if (current is! HomeDataState) return;

    emit(current.copyWith(productsLoading: true, clearProductsError: true));

    try {
      final products = await homeServices.getProducts(categoryId);

      final latest = state;
      if (latest is! HomeDataState) return;

      emit(
        latest.copyWith(
          products: products,
          productsLoading: false,
          clearProductsError: true,
        ),
      );
    } catch (e) {
      final latest = state;
      if (latest is! HomeDataState) return;

      emit(
        latest.copyWith(productsLoading: false, productsError: e.toString()),
      );
    }
  }
}
