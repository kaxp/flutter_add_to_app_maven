// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_listing_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadListingRequest _$LeadListingRequestFromJson(Map<String, dynamic> json) =>
    LeadListingRequest(
      agentMobile: json['agentMobile'] as String,
      page: json['page'] as int,
      leadStatusParentId: json['lead_status_parent_id'] as int?,
    );

Map<String, dynamic> _$LeadListingRequestToJson(LeadListingRequest instance) =>
    <String, dynamic>{
      'agentMobile': instance.agentMobile,
      'page': instance.page,
      'lead_status_parent_id': instance.leadStatusParentId,
    };
