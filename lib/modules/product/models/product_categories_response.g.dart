// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategoriesResponse _$ProductCategoriesResponseFromJson(
        Map<String, dynamic> json) =>
    ProductCategoriesResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => ProductCategoriesData.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'] as int?,
      message: json['message'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$ProductCategoriesResponseToJson(
        ProductCategoriesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
    };

ProductCategoriesData _$ProductCategoriesDataFromJson(
        Map<String, dynamic> json) =>
    ProductCategoriesData(
      categoryName: json['categoryName'] as String,
      categoryId: json['categoryId'] as int,
      categoryIcon: json['categoryIcon'] as String,
      earnUpto: json['earnUpto'] as String?,
    );

Map<String, dynamic> _$ProductCategoriesDataToJson(
        ProductCategoriesData instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'categoryId': instance.categoryId,
      'categoryIcon': instance.categoryIcon,
      'earnUpto': instance.earnUpto,
    };
