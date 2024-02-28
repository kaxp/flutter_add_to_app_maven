// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_listing_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListingRequest _$ProductListingRequestFromJson(
        Map<String, dynamic> json) =>
    ProductListingRequest(
      categoryId: json['categoryId'] as int,
      searchString: json['searchString'] as String,
    );

Map<String, dynamic> _$ProductListingRequestToJson(
        ProductListingRequest instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'searchString': instance.searchString,
    };
