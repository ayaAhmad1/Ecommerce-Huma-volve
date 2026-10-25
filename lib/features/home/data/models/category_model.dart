import 'package:commerce_app/features/home/domain/entities/home_category_entity.dart';

class HomeCategoryModel extends HomeCategoryEntity {
  HomeCategoryModel({super.id, super.name});

  HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
