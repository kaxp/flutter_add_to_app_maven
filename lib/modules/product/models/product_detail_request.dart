// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'product_detail_request.g.dart';

@JsonSerializable()
class ProductDetailRequest {
  ProductDetailRequest({
    required this.productId,
  });

  final int productId;

  factory ProductDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailRequestToJson(this);
}
