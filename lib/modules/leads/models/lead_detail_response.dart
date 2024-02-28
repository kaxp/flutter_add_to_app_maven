import 'package:json_annotation/json_annotation.dart';

part 'lead_detail_response.g.dart';

@JsonSerializable()
class LeadDetailResponse {
  int? code;
  String? message;
  bool? success;
  LeadDetailData? data;

  LeadDetailResponse({this.data, this.code, this.message, this.success});

  factory LeadDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$LeadDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LeadDetailResponseToJson(this);
}

@JsonSerializable()
class LeadDetailData {
  final int? productId;
  final String? productLogo;
  final String? productStatus;
  final String? productTitle;
  final String? costomer_name;
  final String? created_at;
  final int? leadId;
  final String? leadRemark;
  final String? leadStatus;
  final int? leadStatusId;
  final String? leadTitle;
  final num? mobile_no;
  final String? updated_at;
  final List<JourneyObj> journey;
  final bool? isQuery;
  final bool? isQueryActive;
  final bool? isDisputeVisible;

  const LeadDetailData({
    required this.productId,
    required this.productLogo,
    required this.productStatus,
    required this.productTitle,
    required this.costomer_name,
    required this.created_at,
    required this.leadId,
    required this.leadRemark,
    required this.leadStatus,
    required this.leadStatusId,
    required this.leadTitle,
    required this.mobile_no,
    required this.updated_at,
    required this.journey,
    required this.isQuery,
    required this.isQueryActive,
    required this.isDisputeVisible,
  });

  factory LeadDetailData.fromJson(Map<String, dynamic> json) =>
      _$LeadDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$LeadDetailDataToJson(this);
}

@JsonSerializable()
class JourneyObj {
  String? lead_status_title;
  String? lead_sub_status;
  String? lead_sub_remark;
  String? updated_at;

  JourneyObj({
    this.lead_status_title,
    this.lead_sub_status,
    this.lead_sub_remark,
    this.updated_at,
  });

  factory JourneyObj.fromJson(Map<String, dynamic> json) =>
      _$JourneyObjFromJson(json);

  Map<String, dynamic> toJson() => _$JourneyObjToJson(this);
}
