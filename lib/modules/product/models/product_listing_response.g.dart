// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_listing_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListingResponse _$ProductListingResponseFromJson(
        Map<String, dynamic> json) =>
    ProductListingResponse(
      data: json['data'] == null
          ? null
          : ProductListings.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int?,
      message: json['message'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$ProductListingResponseToJson(
        ProductListingResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
    };

ProductListings _$ProductListingsFromJson(Map<String, dynamic> json) =>
    ProductListings(
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductListingData.fromJson(e as Map<String, dynamic>))
          .toList(),
      creditCardBenefits: (json['creditCardBenefits'] as List<dynamic>)
          .map((e) => CreditCardBenefits.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductListingsToJson(ProductListings instance) =>
    <String, dynamic>{
      'products': instance.products,
      'creditCardBenefits': instance.creditCardBenefits,
    };

ProductListingData _$ProductListingDataFromJson(Map<String, dynamic> json) =>
    ProductListingData(
      productId: json['productId'] as int,
      productCatId: json['productCatId'] as int,
      productTitle: json['productTitle'] as String,
      productSubTitle: json['productSubTitle'] as String,
      productLogo: json['productLogo'] as String,
      status: ProductStatus.fromJson(json['status'] as Map<String, dynamic>),
      joiningFee: json['joiningFee'] as String?,
      annualFee: json['annualFee'] as String?,
      interestRate: json['interestRate'] as String?,
      processingFee: json['processingFee'] as String?,
      uptoLoan: json['uptoLoan'] as String?,
      features:
          (json['features'] as List<dynamic>).map((e) => e as String).toList(),
      benefits:
          (json['benefits'] as List<dynamic>).map((e) => e as int).toList(),
      shareData:
          ShareDataModel.fromJson(json['shareData'] as Map<String, dynamic>),
      earnUpto: json['earnUpto'] as String?,
    );

Map<String, dynamic> _$ProductListingDataToJson(ProductListingData instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productCatId': instance.productCatId,
      'productTitle': instance.productTitle,
      'productSubTitle': instance.productSubTitle,
      'productLogo': instance.productLogo,
      'status': instance.status,
      'joiningFee': instance.joiningFee,
      'annualFee': instance.annualFee,
      'interestRate': instance.interestRate,
      'processingFee': instance.processingFee,
      'uptoLoan': instance.uptoLoan,
      'features': instance.features,
      'benefits': instance.benefits,
      'shareData': instance.shareData,
      'earnUpto': instance.earnUpto,
    };

CreditCardBenefits _$CreditCardBenefitsFromJson(Map<String, dynamic> json) =>
    CreditCardBenefits(
      id: json['id'] as int,
      title: json['title'] as String,
    );

Map<String, dynamic> _$CreditCardBenefitsToJson(CreditCardBenefits instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

ProductStatus _$ProductStatusFromJson(Map<String, dynamic> json) =>
    ProductStatus(
      id: json['id'] as int,
      isActive: json['isActive'] as int,
      text: json['text'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$ProductStatusToJson(ProductStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isActive': instance.isActive,
      'text': instance.text,
      'color': instance.color,
    };

ShareDataModel _$ShareDataModelFromJson(Map<String, dynamic> json) =>
    ShareDataModel(
      languageId: json['languageId'] as int,
      locale: json['locale'] as String,
      language: json['language'] as String,
      shareContent: json['shareContent'] as String?,
      shareImage: json['shareImage'] as String,
      shareLink: json['shareLink'] as String,
    );

Map<String, dynamic> _$ShareDataModelToJson(ShareDataModel instance) =>
    <String, dynamic>{
      'languageId': instance.languageId,
      'locale': instance.locale,
      'language': instance.language,
      'shareContent': instance.shareContent,
      'shareImage': instance.shareImage,
      'shareLink': instance.shareLink,
    };
