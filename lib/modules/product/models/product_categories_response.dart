import 'package:json_annotation/json_annotation.dart';

part 'product_categories_response.g.dart';

@JsonSerializable()
class ProductCategoriesResponse {
  ProductCategoriesResponse({
    required this.data,
    this.code,
    this.message,
    this.success,
  });

  List<ProductCategoriesData> data;
  int? code;
  String? message;
  bool? success;

  factory ProductCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return _$ProductCategoriesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductCategoriesResponseToJson(this);
}

@JsonSerializable()
class ProductCategoriesData {
  const ProductCategoriesData({
    required this.categoryName,
    required this.categoryId,
    required this.categoryIcon,
    required this.earnUpto,
  });

  final String categoryName;
  final int categoryId;
  final String categoryIcon;
  final String? earnUpto;

  factory ProductCategoriesData.fromJson(Map<String, dynamic> json) {
    return _$ProductCategoriesDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductCategoriesDataToJson(this);
}
