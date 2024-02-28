import 'package:json_annotation/json_annotation.dart';

part 'product_detail_response.g.dart';

@JsonSerializable()
class ProductDetailResponse {
  ProductDetailResponse({
    required this.data,
    this.code,
    this.message,
    this.success,
  });

  ProductDetailData data;
  int? code;
  String? message;
  bool? success;

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$ProductDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductDetailResponseToJson(this);
}

@JsonSerializable()
class ProductDetailData {
  const ProductDetailData({
    required this.productId,
    required this.productTitle,
    required this.productSubTitle,
    required this.productLogo,
    required this.bannerImage,
    required this.videoUrl,
    required this.shareData,
    required this.tabs,
    required this.status,
    required this.earnUptoKey,
    required this.earnUptoValue,
  });

  final int productId;
  final String? productTitle;
  final String? productSubTitle;
  final String? productLogo;
  final String? bannerImage;
  final String? videoUrl;
  final ShareDataModel shareData;
  final ProductDetailTabs tabs;
  final ProductDetailStatus status;
  final String? earnUptoKey;
  final String? earnUptoValue;

  factory ProductDetailData.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailDataToJson(this);
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
  final String? locale;
  final String? language;
  final String? shareContent;
  final String? shareImage;
  final String? shareLink;

  factory ShareDataModel.fromJson(Map<String, dynamic> json) =>
      _$ShareDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShareDataModelToJson(this);
}

@JsonSerializable()
class ProductDetailTabs {
  ProductDetailTabs({
    this.details,
    this.marketing,
  });

  List<ProductDetailTabData>? details;
  List<String>? marketing;

  factory ProductDetailTabs.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailTabsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailTabsToJson(this);
}

@JsonSerializable()
class ProductDetailStatus {
  const ProductDetailStatus({
    required this.id,
    required this.text,
    required this.color,
    required this.enableShare,
  });

  final int? id;
  final String? text;
  final String? color;
  final bool? enableShare;

  factory ProductDetailStatus.fromJson(Map<String, dynamic> json) {
    return _$ProductDetailStatusFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductDetailStatusToJson(this);
}

@JsonSerializable()
class ProductDetailTabData {
  ProductDetailTabData({
    required this.tabName,
    this.content,
  });

  String tabName;
  List<ProductDetailTabsContent>? content;

  factory ProductDetailTabData.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailTabDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailTabDataToJson(this);
}

@JsonSerializable()
class ProductDetailTabsContent {
  ProductDetailTabsContent({
    required this.title,
    this.content,
    this.video,
  });

  String? title;
  String? content;
  String? video;

  factory ProductDetailTabsContent.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailTabsContentFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailTabsContentToJson(this);
}
