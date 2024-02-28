import 'dart:io';

import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_detail_request.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_detail_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_listing_request.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_listing_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_query_options_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_query_response.dart';
import 'package:kapil_add_to_app_flutter/networking/retrofit/leads_api_client.dart';

class LeadsRepo {
  final leadsApiClient = LeadsApiClient();

  Future<LeadListingResponse> getLeadsListing(
      {required String agentMobile, required int page, int? leadParentId}) {
    final body = LeadListingRequest(
      agentMobile: agentMobile,
      page: page,
      leadStatusParentId: leadParentId,
    );

    return leadsApiClient.getLeadsListing(body: body);
  }

  Future<LeadDetailResponse> getLeadDetailById({required int leadId}) {
    final body = LeadDetailRequest(
      leadId: leadId,
    );

    return leadsApiClient.getLeadDetailById(body: body);
  }

  Future<LeadQueryResponse> getLeadQueries({required int leadId}) {
    final body = LeadDetailRequest(
      leadId: leadId,
    );

    return leadsApiClient.getLeadQueries(body: body);
  }

  Future<LeadQueryResponse> submitQuery(
      {required int leadId,
      required String comment,
      required String queryType,
      required List<File>? filenames}) {
    return leadsApiClient.submitQuery(
      leadId: leadId,
      comment: comment,
      queryType: queryType,
      files: filenames,
    );
  }

  Future<LeadQueryOptionsResponse> getQueriesOptions() {
    return leadsApiClient.getQueriesOptions();
  }
}
