import 'package:json_annotation/json_annotation.dart';

part 'lead_detail_request.g.dart';

@JsonSerializable()
class LeadDetailRequest {
  const LeadDetailRequest({
    required this.leadId,
  });
  final int leadId;

  factory LeadDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$LeadDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LeadDetailRequestToJson(this);
}
