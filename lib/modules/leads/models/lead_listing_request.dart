import 'package:json_annotation/json_annotation.dart';

part 'lead_listing_request.g.dart';

@JsonSerializable()
class LeadListingRequest {
  const LeadListingRequest({
    required this.agentMobile,
    required this.page,
    this.leadStatusParentId,
  });
  final String agentMobile;
  final int page;
  @JsonKey(name: 'lead_status_parent_id')
  final int? leadStatusParentId;

  factory LeadListingRequest.fromJson(Map<String, dynamic> json) =>
      _$LeadListingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LeadListingRequestToJson(this);
}
