// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailResponse _$ProductDetailResponseFromJson(
        Map<String, dynamic> json) =>
    ProductDetailResponse(
      data: ProductDetailData.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int?,
      message: json['message'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$ProductDetailResponseToJson(
        ProductDetailResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
    };

ProductDetailData _$ProductDetailDataFromJson(Map<String, dynamic> json) =>
    ProductDetailData(
      productId: json['productId'] as int,
      productTitle: json['productTitle'] as String?,
      productSubTitle: json['productSubTitle'] as String?,
      productLogo: json['productLogo'] as String?,
      bannerImage: json['bannerImage'] as String?,
      videoUrl: json['videoUrl'] as String?,
      shareData:
          ShareDataModel.fromJson(json['shareData'] as Map<String, dynamic>),
      tabs: ProductDetailTabs.fromJson(json['tabs'] as Map<String, dynamic>),
      status:
          ProductDetailStatus.fromJson(json['status'] as Map<String, dynamic>),
      earnUptoKey: json['earnUptoKey'] as String?,
      earnUptoValue: json['earnUptoValue'] as String?,
    );

Map<String, dynamic> _$ProductDetailDataToJson(ProductDetailData instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productTitle': instance.productTitle,
      'productSubTitle': instance.productSubTitle,
      'productLogo': instance.productLogo,
      'bannerImage': instance.bannerImage,
      'videoUrl': instance.videoUrl,
      'shareData': instance.shareData,
      'tabs': instance.tabs,
      'status': instance.status,
      'earnUptoKey': instance.earnUptoKey,
      'earnUptoValue': instance.earnUptoValue,
    };

ShareDataModel _$ShareDataModelFromJson(Map<String, dynamic> json) =>
    ShareDataModel(
      languageId: json['languageId'] as int,
      locale: json['locale'] as String?,
      language: json['language'] as String?,
      shareContent: json['shareContent'] as String?,
      shareImage: json['shareImage'] as String?,
      shareLink: json['shareLink'] as String?,
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

ProductDetailTabs _$ProductDetailTabsFromJson(Map<String, dynamic> json) =>
    ProductDetailTabs(
      details: (json['details'] as List<dynamic>?)
          ?.map((e) => ProductDetailTabData.fromJson(e as Map<String, dynamic>))
          .toList(),
      marketing: (json['marketing'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProductDetailTabsToJson(ProductDetailTabs instance) =>
    <String, dynamic>{
      'details': instance.details,
      'marketing': instance.marketing,
    };

ProductDetailStatus _$ProductDetailStatusFromJson(Map<String, dynamic> json) =>
    ProductDetailStatus(
      id: json['id'] as int?,
      text: json['text'] as String?,
      color: json['color'] as String?,
      enableShare: json['enableShare'] as bool?,
    );

Map<String, dynamic> _$ProductDetailStatusToJson(
        ProductDetailStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'color': instance.color,
      'enableShare': instance.enableShare,
    };

ProductDetailTabData _$ProductDetailTabDataFromJson(
        Map<String, dynamic> json) =>
    ProductDetailTabData(
      tabName: json['tabName'] as String,
      content: (json['content'] as List<dynamic>?)
          ?.map((e) =>
              ProductDetailTabsContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductDetailTabDataToJson(
        ProductDetailTabData instance) =>
    <String, dynamic>{
      'tabName': instance.tabName,
      'content': instance.content,
    };

ProductDetailTabsContent _$ProductDetailTabsContentFromJson(
        Map<String, dynamic> json) =>
    ProductDetailTabsContent(
      title: json['title'] as String?,
      content: json['content'] as String?,
      video: json['video'] as String?,
    );

Map<String, dynamic> _$ProductDetailTabsContentToJson(
        ProductDetailTabsContent instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'video': instance.video,
    };
