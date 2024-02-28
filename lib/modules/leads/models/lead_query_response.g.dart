// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_query_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadQueryResponse _$LeadQueryResponseFromJson(Map<String, dynamic> json) =>
    LeadQueryResponse(
      data: json['data'] == null
          ? null
          : LeadQueryData.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$LeadQueryResponseToJson(LeadQueryResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'success': instance.success,
      'data': instance.data,
    };

DocMedia _$DocMediaFromJson(Map<String, dynamic> json) => DocMedia(
      url: json['url'] as String?,
      name: json['name'] as String?,
      is_downloaded: json['is_downloaded'] as bool?,
    );

Map<String, dynamic> _$DocMediaToJson(DocMedia instance) => <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'is_downloaded': instance.is_downloaded,
    };

Queries _$QueriesFromJson(Map<String, dynamic> json) => Queries(
      documentFile: (json['documentFile'] as List<dynamic>?)
          ?.map((e) => DocMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
      documentImage: (json['documentImage'] as List<dynamic>?)
          ?.map((e) => DocMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      document: json['document'],
      comment: json['comment'] as String?,
      adminId: json['adminId'] as int?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$QueriesToJson(Queries instance) => <String, dynamic>{
      'documentFile': instance.documentFile,
      'documentImage': instance.documentImage,
      'createdAt': instance.createdAt,
      'document': instance.document,
      'comment': instance.comment,
      'adminId': instance.adminId,
      'id': instance.id,
    };

LeadQueryData _$LeadQueryDataFromJson(Map<String, dynamic> json) =>
    LeadQueryData(
      queries: (json['queries'] as List<dynamic>?)
          ?.map((e) => Queries.fromJson(e as Map<String, dynamic>))
          .toList(),
      queryType: json['queryType'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$LeadQueryDataToJson(LeadQueryData instance) =>
    <String, dynamic>{
      'queryType': instance.queryType,
      'status': instance.status,
      'queries': instance.queries,
    };
