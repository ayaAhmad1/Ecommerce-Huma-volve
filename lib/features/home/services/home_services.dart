import 'package:commerce_app/core/constants/api_endpoints.dart';
import 'package:commerce_app/core/network/api_client.dart';
import 'package:commerce_app/features/home/services/models/category_model.dart';
import 'package:commerce_app/features/home/services/models/product_model.dart';

class HomeServices {
  final ApiClient apiClient;
  HomeServices(this.apiClient);
  Future<List<CategoryModel>> categories() async {
    final response = await apiClient.dio.get(ApiEndpoints.categoriesEndpoint);
    final List data = response.data;
    final List<CategoryModel> categories = data
        .map((e) => CategoryModel.fromJson(e))
        .toList();
    return categories;
  }

  Future<List<ProductModel>> getProducts(int? categoryId) async {
    final response = await apiClient.dio.get(
      '${ApiEndpoints.categoriesEndpoint}/$categoryId/'
      '${ApiEndpoints.productsEndpoint}',
    );

    final List<dynamic> data = response.data as List<dynamic>;

    return data
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
