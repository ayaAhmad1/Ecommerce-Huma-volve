import 'package:commerce_app/core/constants/api_endpoints.dart';
import 'package:commerce_app/core/network/api_client.dart';
import 'package:commerce_app/features/home/data/models/category_model.dart';
import 'package:commerce_app/features/home/data/models/data_source/home_remote_data_source.dart';
import 'package:commerce_app/features/home/data/models/product_model.dart';

class HomeRemoteDataSourceImplement implements HomeRemoteDataSource {
  final ApiClient apiClient;
  HomeRemoteDataSourceImplement({required this.apiClient});

  @override
  Future<List<HomeCategoryModel>> getCategories() async {
    final response = await apiClient.dio.get(ApiEndpoints.categoriesEndpoint);
    final List data = response.data;
    final List<HomeCategoryModel> categories = data
        .map((e) => HomeCategoryModel.fromJson(e))
        .toList();
    return categories;
  }

  @override
  Future<List<HomeProductModel>> getProducts(int? categoryId) async {
    final response = await apiClient.dio.get(
      '${ApiEndpoints.categoriesEndpoint}/$categoryId/'
      '${ApiEndpoints.productsEndpoint}',
    );

    final List data = response.data;
    final List<HomeProductModel> products = data
        .map((e) => HomeProductModel.fromJson(e))
        .toList();
    return products;
  }
}
