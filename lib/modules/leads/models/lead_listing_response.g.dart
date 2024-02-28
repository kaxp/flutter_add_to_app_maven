// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_listing_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadListingResponse _$LeadListingResponseFromJson(Map<String, dynamic> json) =>
    LeadListingResponse(
      data: json['data'] == null
          ? null
          : LeadListingData.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int?,
      message: json['message'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$LeadListingResponseToJson(
        LeadListingResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
    };

LeadListingData _$LeadListingDataFromJson(Map<String, dynamic> json) =>
    LeadListingData(
      completedLeads: json['completedLeads'] as int?,
      inprocessLeads: json['inprocessLeads'] as int?,
      actionrequiredLeads: json['actionrequiredLeads'] as int?,
      leads: json['leads'] == null
          ? null
          : Leads.fromJson(json['leads'] as Map<String, dynamic>),
      filterProducts: (json['filterProducts'] as List<dynamic>?)
          ?.map((e) => FilterProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      rejectedLeads: json['rejectedLeads'] as int?,
      totalLeads: json['totalLeads'] as int?,
    );

Map<String, dynamic> _$LeadListingDataToJson(LeadListingData instance) =>
    <String, dynamic>{
      'totalLeads': instance.totalLeads,
      'inprocessLeads': instance.inprocessLeads,
      'actionrequiredLeads': instance.actionrequiredLeads,
      'rejectedLeads': instance.rejectedLeads,
      'completedLeads': instance.completedLeads,
      'leads': instance.leads,
      'filterProducts': instance.filterProducts,
    };

FilterProduct _$FilterProductFromJson(Map<String, dynamic> json) =>
    FilterProduct(
      categoryName: json['categoryName'] as String?,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      catId: json['catId'] as int?,
    );

Map<String, dynamic> _$FilterProductToJson(FilterProduct instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'catId': instance.catId,
      'products': instance.products,
    };

TempFilterProduct _$TempFilterProductFromJson(Map<String, dynamic> json) =>
    TempFilterProduct(
      index: json['index'] as int?,
      categoryName: json['categoryName'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => TempProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      catId: json['catId'] as int?,
    );

Map<String, dynamic> _$TempFilterProductToJson(TempFilterProduct instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'catId': instance.catId,
      'products': instance.products,
      'index': instance.index,
    };

TempProduct _$TempProductFromJson(Map<String, dynamic> json) => TempProduct(
      id: json['id'] as int?,
      productName: json['productName'] as String?,
      index: json['index'] as int?,
    );

Map<String, dynamic> _$TempProductToJson(TempProduct instance) =>
    <String, dynamic>{
      'index': instance.index,
      'id': instance.id,
      'productName': instance.productName,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int?,
      productName: json['productName'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'productName': instance.productName,
    };

Leads _$LeadsFromJson(Map<String, dynamic> json) => Leads(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Lead.fromJson(e as Map<String, dynamic>))
          .toList(),
      current_page: json['current_page'] as int?,
      first_page_url: json['first_page_url'] as String?,
      from: json['from'] as int?,
      last_page: json['last_page'] as int?,
      last_page_url: json['last_page_url'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      next_page_url: json['next_page_url'] as String?,
      path: json['path'] as String?,
      per_page: json['per_page'] as int?,
      prev_page_url: json['prev_page_url'],
      to: json['to'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$LeadsToJson(Leads instance) => <String, dynamic>{
      'data': instance.data,
      'current_page': instance.current_page,
      'first_page_url': instance.first_page_url,
      'from': instance.from,
      'last_page': instance.last_page,
      'last_page_url': instance.last_page_url,
      'links': instance.links,
      'next_page_url': instance.next_page_url,
      'path': instance.path,
      'per_page': instance.per_page,
      'prev_page_url': instance.prev_page_url,
      'to': instance.to,
      'total': instance.total,
    };

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      active: json['active'] as bool?,
      label: json['label'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'active': instance.active,
      'label': instance.label,
      'url': instance.url,
    };

InfoButton _$InfoButtonFromJson(Map<String, dynamic> json) => InfoButton(
      createdDate: json['createdDate'] as String?,
      createdDateSubTitle: json['createdDateSubTitle'] as String?,
    );

Map<String, dynamic> _$InfoButtonToJson(InfoButton instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate,
      'createdDateSubTitle': instance.createdDateSubTitle,
    };

Lead _$LeadFromJson(Map<String, dynamic> json) => Lead(
      customerName: json['customerName'] as String?,
      leadId: json['leadId'] as int?,
      leadRemark: json['leadRemark'] as String?,
      leadStatus: json['leadStatus'] as String?,
      leadStatusId: json['leadStatusId'] as int?,
      leadStatusParentId: json['leadStatusParentId'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      productTitle: json['productTitle'] as String?,
      productLogo: json['productLogo'] as String?,
      mobileNo: json['mobileNo'] as num?,
      lastUpdatedDate: json['lastUpdatedDate'] as String?,
      lastUpdatedDateSubTitle: json['lastUpdatedDateSubTitle'] as String?,
      createdDateSubTitle: json['createdDateSubTitle'] as String?,
      nextUpdateSubTitle: json['nextUpdateSubTitle'] as String?,
      nextUpdate: json['nextUpdate'] as String?,
      sectionId: json['sectionId'] as int?,
      expectedPayout: json['expectedPayout'] as String?,
      isQuery: json['isQuery'] as bool?,
      isQueryActive: json['isQueryActive'] as bool?,
      isDisputeVisible: json['isDisputeVisible'] as bool?,
    );

Map<String, dynamic> _$LeadToJson(Lead instance) => <String, dynamic>{
      'leadId': instance.leadId,
      'productTitle': instance.productTitle,
      'productLogo': instance.productLogo,
      'leadRemark': instance.leadRemark,
      'leadStatus': instance.leadStatus,
      'leadStatusId': instance.leadStatusId,
      'leadStatusParentId': instance.leadStatusParentId,
      'customerName': instance.customerName,
      'mobileNo': instance.mobileNo,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'lastUpdatedDate': instance.lastUpdatedDate,
      'lastUpdatedDateSubTitle': instance.lastUpdatedDateSubTitle,
      'createdDateSubTitle': instance.createdDateSubTitle,
      'nextUpdate': instance.nextUpdate,
      'nextUpdateSubTitle': instance.nextUpdateSubTitle,
      'sectionId': instance.sectionId,
      'expectedPayout': instance.expectedPayout,
      'isQuery': instance.isQuery,
      'isQueryActive': instance.isQueryActive,
      'isDisputeVisible': instance.isDisputeVisible,
    };
