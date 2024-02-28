import 'package:json_annotation/json_annotation.dart';

part 'product_listing_response.g.dart';

@JsonSerializable()
class ProductListingResponse {
  ProductListingResponse({
    this.data,
    this.code,
    this.message,
    this.success,
  });

  ProductListings? data;
  int? code;
  String? message;
  bool? success;

  factory ProductListingResponse.fromJson(Map<String, dynamic> json) {
    return _$ProductListingResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductListingResponseToJson(this);
}

@JsonSerializable()
class ProductListings {
  const ProductListings({
    required this.products,
    required this.creditCardBenefits,
  });

  final List<ProductListingData> products;
  final List<CreditCardBenefits> creditCardBenefits;

  factory ProductListings.fromJson(Map<String, dynamic> json) {
    return _$ProductListingsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductListingsToJson(this);
}

@JsonSerializable()
class ProductListingData {
  const ProductListingData({
    required this.productId,
    required this.productCatId,
    required this.productTitle,
    required this.productSubTitle,
    required this.productLogo,
    required this.status,
    required this.joiningFee,
    required this.annualFee,
    required this.interestRate,
    required this.processingFee,
    required this.uptoLoan,
    required this.features,
    required this.benefits,
    required this.shareData,
    required this.earnUpto,
  });

  final int productId;
  final int productCatId;
  final String productTitle;
  final String productSubTitle;
  final String productLogo;
  final ProductStatus status;
  final String? joiningFee;
  final String? annualFee;
  final String? interestRate;
  final String? processingFee;
  final String? uptoLoan;
  final List<String> features;
  final List<int> benefits;
  final ShareDataModel shareData;
  final String? earnUpto;

  factory ProductListingData.fromJson(Map<String, dynamic> json) =>
      _$ProductListingDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListingDataToJson(this);
}

@JsonSerializable()
class CreditCardBenefits {
  const CreditCardBenefits({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  factory CreditCardBenefits.fromJson(Map<String, dynamic> json) {
    return _$CreditCardBenefitsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreditCardBenefitsToJson(this);
}

@JsonSerializable()
class ProductStatus {
  const ProductStatus({
    required this.id,
    required this.isActive,
    required this.text,
    required this.color,
  });

  final int id;
  final int isActive;
  final String text;
  final String color;

  factory ProductStatus.fromJson(Map<String, dynamic> json) {
    return _$ProductStatusFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductStatusToJson(this);
}

@JsonSerializable()
class ShareDataModel {
  const ShareDataModel({
    required this.languageId,
    required this.locale,
    required this.language,
    required this.shareContent,
    required this.shareImage,
    required this.shareLink,
  });

  final int languageId;
  final String locale;
  final String language;
  final String? shareContent;
  final String shareImage;
  final String shareLink;

  factory ShareDataModel.fromJson(Map<String, dynamic> json) =>
      _$ShareDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShareDataModelToJson(this);
}
