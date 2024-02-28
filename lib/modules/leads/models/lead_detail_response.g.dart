// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadDetailResponse _$LeadDetailResponseFromJson(Map<String, dynamic> json) =>
    LeadDetailResponse(
      data: json['data'] == null
          ? null
          : LeadDetailData.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int?,
      message: json['message'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$LeadDetailResponseToJson(LeadDetailResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      'data': instance.data,
    };

LeadDetailData _$LeadDetailDataFromJson(Map<String, dynamic> json) =>
    LeadDetailData(
      productId: json['productId'] as int?,
      productLogo: json['productLogo'] as String?,
      productStatus: json['productStatus'] as String?,
      productTitle: json['productTitle'] as String?,
      costomer_name: json['costomer_name'] as String?,
      created_at: json['created_at'] as String?,
      leadId: json['leadId'] as int?,
      leadRemark: json['leadRemark'] as String?,
      leadStatus: json['leadStatus'] as String?,
      leadStatusId: json['leadStatusId'] as int?,
      leadTitle: json['leadTitle'] as String?,
      mobile_no: json['mobile_no'] as num?,
      updated_at: json['updated_at'] as String?,
      journey: (json['journey'] as List<dynamic>)
          .map((e) => JourneyObj.fromJson(e as Map<String, dynamic>))
          .toList(),
      isQuery: json['isQuery'] as bool?,
      isQueryActive: json['isQueryActive'] as bool?,
      isDisputeVisible: json['isDisputeVisible'] as bool?,
    );

Map<String, dynamic> _$LeadDetailDataToJson(LeadDetailData instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productLogo': instance.productLogo,
      'productStatus': instance.productStatus,
      'productTitle': instance.productTitle,
      'costomer_name': instance.costomer_name,
      'created_at': instance.created_at,
      'leadId': instance.leadId,
      'leadRemark': instance.leadRemark,
      'leadStatus': instance.leadStatus,
      'leadStatusId': instance.leadStatusId,
      'leadTitle': instance.leadTitle,
      'mobile_no': instance.mobile_no,
      'updated_at': instance.updated_at,
      'journey': instance.journey,
      'isQuery': instance.isQuery,
      'isQueryActive': instance.isQueryActive,
      'isDisputeVisible': instance.isDisputeVisible,
    };

JourneyObj _$JourneyObjFromJson(Map<String, dynamic> json) => JourneyObj(
      lead_status_title: json['lead_status_title'] as String?,
      lead_sub_status: json['lead_sub_status'] as String?,
      lead_sub_remark: json['lead_sub_remark'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$JourneyObjToJson(JourneyObj instance) =>
    <String, dynamic>{
      'lead_status_title': instance.lead_status_title,
      'lead_sub_status': instance.lead_sub_status,
      'lead_sub_remark': instance.lead_sub_remark,
      'updated_at': instance.updated_at,
    };
