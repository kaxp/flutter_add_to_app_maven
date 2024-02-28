import 'package:json_annotation/json_annotation.dart';

part 'lead_query_options_response.g.dart';

@JsonSerializable()
class LeadQueryOptionsResponse {
  int? statusCode;
  String? message;
  bool? success;
  List<QueryType>? data;

  LeadQueryOptionsResponse({this.data, this.statusCode, this.message, this.success});

  factory LeadQueryOptionsResponse.fromJson(Map<String, dynamic> json) =>
      _$LeadQueryOptionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LeadQueryOptionsResponseToJson(this);
}

@JsonSerializable()
class QueryType {
  final String? queryType;

  const QueryType({
    required this.queryType,
  });

  factory QueryType.fromJson(Map<String, dynamic> json) =>
      _$QueryTypeFromJson(json);

  Map<String, dynamic> toJson() => _$QueryTypeToJson(this);
}
