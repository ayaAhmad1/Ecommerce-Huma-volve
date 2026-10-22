import 'package:commerce_app/features/home/services/models/category_model.dart';

class ProductModel {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  CategoryModel? category;
  List<String>? images;

  ProductModel({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = (json['price'] as num?)?.toInt();
    description = json['description'];

    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
        : null;

    images = (json['images'] as List<dynamic>?)
        ?.map((image) => image.toString())
        .toList();
  }
}
