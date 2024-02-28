// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'product_listing_request.g.dart';

@JsonSerializable()
class ProductListingRequest {
  ProductListingRequest({
    required this.categoryId,
    required this.searchString,
  });

  int categoryId;
  String searchString;

  factory ProductListingRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductListingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListingRequestToJson(this);
}
