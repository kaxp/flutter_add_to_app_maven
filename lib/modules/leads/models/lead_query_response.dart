import 'package:json_annotation/json_annotation.dart';

part 'lead_query_response.g.dart';

@JsonSerializable()
class LeadQueryResponse {
  int? statusCode;
  String? message;
  bool? success;
  LeadQueryData? data;

  LeadQueryResponse({this.data, this.statusCode, this.message, this.success});

  factory LeadQueryResponse.fromJson(Map<String, dynamic> json) =>
      _$LeadQueryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LeadQueryResponseToJson(this);
}

@JsonSerializable()
class DocMedia {
  final String? url;
  final String? name;
  final bool? is_downloaded;

  const DocMedia({
    required this.url,
    required this.name,
    required this.is_downloaded,
  });

  factory DocMedia.fromJson(Map<String, dynamic> json) =>
      _$DocMediaFromJson(json);

  Map<String, dynamic> toJson() => _$DocMediaToJson(this);
}

@JsonSerializable()
class Queries {
  final List<DocMedia>? documentFile;
  final List<DocMedia>? documentImage;
  final String? createdAt;
  final dynamic document;
  final String? comment;
  final int? adminId;
  final int? id;

  const Queries({
    required this.documentFile,
    required this.documentImage,
    required this.createdAt,
    required this.document,
    required this.comment,
    required this.adminId,
    required this.id,
  });

  factory Queries.fromJson(Map<String, dynamic> json) =>
      _$QueriesFromJson(json);

  Map<String, dynamic> toJson() => _$QueriesToJson(this);
}

@JsonSerializable()
class LeadQueryData {
  final String? queryType;
  final bool? status;
  final List<Queries>? queries;

  const LeadQueryData({
    required this.queries,
    required this.queryType,
    required this.status,
  });

  factory LeadQueryData.fromJson(Map<String, dynamic> json) =>
      _$LeadQueryDataFromJson(json);

  Map<String, dynamic> toJson() => _$LeadQueryDataToJson(this);
}
