// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_query_options_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadQueryOptionsResponse _$LeadQueryOptionsResponseFromJson(
        Map<String, dynamic> json) =>
    LeadQueryOptionsResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => QueryType.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$LeadQueryOptionsResponseToJson(
        LeadQueryOptionsResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'success': instance.success,
      'data': instance.data,
    };

QueryType _$QueryTypeFromJson(Map<String, dynamic> json) => QueryType(
      queryType: json['queryType'] as String?,
    );

Map<String, dynamic> _$QueryTypeToJson(QueryType instance) => <String, dynamic>{
      'queryType': instance.queryType,
    };
