import 'package:commerce_app/features/home/data/models/category_model.dart';
import 'package:commerce_app/features/home/domain/entities/home_product_entity.dart';

class HomeProductModel extends HomeProductEntity {
  HomeProductModel({
    super.id,
    super.title,
    super.slug,
    super.price,
    super.description,
    super.category,
    super.images,
  });

  HomeProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];

    category = json['category'] != null
        ? HomeCategoryModel.fromJson(json['category'])
        : null!;

    images = json['images'].cast<String>();
  }
}
