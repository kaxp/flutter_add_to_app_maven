import 'package:json_annotation/json_annotation.dart';

part 'lead_listing_response.g.dart';

@JsonSerializable()
class LeadListingResponse {
  LeadListingData? data;
  int? code;
  String? message;
  bool? success;

  LeadListingResponse({this.data, this.code, this.message, this.success});

  factory LeadListingResponse.fromJson(Map<String, dynamic> json) =>
      _$LeadListingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LeadListingResponseToJson(this);
}

@JsonSerializable()
class LeadListingData {
  int? totalLeads;
  int? inprocessLeads;
  int? actionrequiredLeads;
  int? rejectedLeads;
  int? completedLeads;

  Leads? leads;
  List<FilterProduct>? filterProducts;

  LeadListingData(
      {this.completedLeads,
      this.inprocessLeads,
      this.actionrequiredLeads,
      this.leads,
      this.filterProducts,
      this.rejectedLeads,
      this.totalLeads});

  factory LeadListingData.fromJson(Map<String, dynamic> json) =>
      _$LeadListingDataFromJson(json);

  Map<String, dynamic> toJson() => _$LeadListingDataToJson(this);
}

@JsonSerializable()
class FilterProduct {
  String? categoryName;
  int? catId;
  List<Product> products;
  @JsonKey(includeFromJson: false)
  bool isSelected;
  @JsonKey(includeFromJson: false)
  bool showCancelFor;

  FilterProduct({
    this.categoryName,
    this.products = const [],
    this.catId,
    this.isSelected = false,
    this.showCancelFor = false,
  });

  factory FilterProduct.fromJson(Map<String, dynamic> json) =>
      _$FilterProductFromJson(json);

  Map<String, dynamic> toJson() => _$FilterProductToJson(this);
}

@JsonSerializable()
class TempFilterProduct {
  String? categoryName;
  int? catId;
  List<TempProduct>? products;
  @JsonKey(includeFromJson: false)
  bool isSelected;
  @JsonKey(includeFromJson: false)
  bool showCancelFor;
  int? index;
  @JsonKey(includeFromJson: false)
  bool showSelectAll;

  TempFilterProduct({
    this.index,
    this.categoryName,
    this.products,
    this.catId,
    this.isSelected = false,
    this.showCancelFor = false,
    this.showSelectAll = true,
  });

  factory TempFilterProduct.fromJson(Map<String, dynamic> json) =>
      _$TempFilterProductFromJson(json);

  Map<String, dynamic> toJson() => _$TempFilterProductToJson(this);
}

@JsonSerializable()
class TempProduct {
  int? index;
  int? id;
  String? productName;
  @JsonKey(includeFromJson: false)
  bool isSelected;

  TempProduct({
    this.id,
    this.productName,
    this.isSelected = false,
    this.index,
  });

  factory TempProduct.fromJson(Map<String, dynamic> json) =>
      _$TempProductFromJson(json);

  Map<String, dynamic> toJson() => _$TempProductToJson(this);
}

@JsonSerializable()
class Product {
  int? id;
  String? productName;
  @JsonKey(includeFromJson: false)
  bool isSelected;

  Product({
    this.id,
    this.productName,
    this.isSelected = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Leads {
  List<Lead>? data;
  int? current_page;
  String? first_page_url;
  int? from;
  int? last_page;
  String? last_page_url;
  List<Link>? links;
  String? next_page_url;
  String? path;
  int? per_page;
  Object? prev_page_url;
  int? to;
  int? total;

  Leads(
      {this.data,
      this.current_page,
      this.first_page_url,
      this.from,
      this.last_page,
      this.last_page_url,
      this.links,
      this.next_page_url,
      this.path,
      this.per_page,
      this.prev_page_url,
      this.to,
      this.total});

  factory Leads.fromJson(Map<String, dynamic> json) => _$LeadsFromJson(json);

  Map<String, dynamic> toJson() => _$LeadsToJson(this);
}

@JsonSerializable()
class Link {
  bool? active;
  String? label;
  String? url;

  Link({this.active, this.label, this.url});

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);
}

@JsonSerializable()
class InfoButton {
  String? createdDate;
  String? createdDateSubTitle;

  InfoButton({this.createdDate, this.createdDateSubTitle});

  factory InfoButton.fromJson(Map<String, dynamic> json) =>
      _$InfoButtonFromJson(json);

  Map<String, dynamic> toJson() => _$InfoButtonToJson(this);
}

@JsonSerializable()
class Lead {
  int? leadId;
  String? productTitle;
  String? productLogo;
  String? leadRemark;
  String? leadStatus;
  int? leadStatusId;
  int? leadStatusParentId;
  String? customerName;
  num? mobileNo;
  String? createdAt;
  String? updatedAt;
  String? lastUpdatedDate;
  String? lastUpdatedDateSubTitle;
  String? createdDateSubTitle;
  String? nextUpdate;
  String? nextUpdateSubTitle;
  int? sectionId;
  String? expectedPayout;
  bool? isQuery;
  bool? isQueryActive;
  bool? isDisputeVisible;

  Lead({
    this.customerName,
    this.leadId,
    this.leadRemark,
    this.leadStatus,
    this.leadStatusId,
    this.leadStatusParentId,
    this.createdAt,
    this.updatedAt,
    this.productTitle,
    this.productLogo,
    this.mobileNo,
    this.lastUpdatedDate,
    this.lastUpdatedDateSubTitle,
    this.createdDateSubTitle,
    this.nextUpdateSubTitle,
    this.nextUpdate,
    this.sectionId,
    this.expectedPayout,
    this.isQuery,
    this.isQueryActive,
    this.isDisputeVisible,
  });

  factory Lead.fromJson(Map<String, dynamic> json) => _$LeadFromJson(json);

  Map<String, dynamic> toJson() => _$LeadToJson(this);
}
