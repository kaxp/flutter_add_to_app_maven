import 'dart:io';

import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_detail_request.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_detail_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_listing_request.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_listing_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_query_options_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_query_response.dart';
import 'package:kapil_add_to_app_flutter/networking/constants/network_constants.dart';
import 'package:kapil_add_to_app_flutter/networking/http_client.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'leads_api_client.g.dart';

@RestApi()
abstract class LeadsApiClient {
  factory LeadsApiClient() {
    return _LeadsApiClient(
      defaultHttpClient(),
      baseUrl: NetworkConstants.baseUrl,
    );
  }

  @POST('/lead_listing')
  Future<LeadListingResponse> getLeadsListing({
    @Body() required LeadListingRequest body,
  });

  @POST('/lead_details')
  Future<LeadDetailResponse> getLeadDetailById({
    @Body() required LeadDetailRequest body,
  });

  @POST('/get_all_disputes')
  Future<LeadQueryResponse> getLeadQueries({
    @Body() required LeadDetailRequest body,
  });

  @POST('/save_dispute_query')
  Future<LeadQueryResponse> submitQuery(
      {@Part(value: 'comment') String? comment,
      @Part(value: 'queryType') String? queryType,
      @Part(value: 'leadId') int? leadId,
      @Part(value: 'filenames[]') List<File>? files});

  @GET('/dispute_options')
  Future<LeadQueryOptionsResponse> getQueriesOptions();
}
