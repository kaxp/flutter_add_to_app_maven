import 'package:kapil_add_to_app_flutter/injection_container.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_listing_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_query_options_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/repositories/leads_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

part 'leads_listing_state.dart';

class LeadsListingBloc extends Cubit<LeadsListingState> {
  LeadsListingBloc() : super(LeadsListingInitial());
  LeadListingData? initialLeads;
  List<QueryType>? queriesOptions;
  final agentMobileNumber = sdkInitResponse.agentMobile;
  final _repo = LeadsRepo();

  Future<void> getInitialLeads(
    int page, {
    int? leadParentId,
  }) async {
    try {
      emit(LeadsListingLoading());

      final result = await _repo.getLeadsListing(
        agentMobile: agentMobileNumber,
        page: page,
        leadParentId: leadParentId,
      );

      if (result.data != null) {
        initialLeads = result.data;
        final List<Lead>? leads = initialLeads?.leads?.data;
        if (leads != null && leads.isNotEmpty) {
          emit(
            LeadsListingLoaded(
              leadListingData: initialLeads!,
            ),
          );
        } else {
          emit(LeadsListingEmpty(leadListingData: initialLeads!));
        }
      }
    } on DioException catch (error) {
      emit(
        LeadsListingError(
          exception: error,
          // TODO(kaxp) handle the error message properly
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> getMoreLeads(
    int page, {
    int? leadParentId,
  }) async {
    try {
      emit(LeadsListingLoadMore(leadListingData: state.leadListingData!));
      final result = await _repo.getLeadsListing(
          agentMobile: agentMobileNumber,
          page: page,
          leadParentId: leadParentId);

      if (result.data != null) {
        initialLeads!.leads!.data!.addAll(result.data!.leads!.data!);
        emit(
          LeadsListingLoaded(
            leadListingData: initialLeads!,
          ),
        );
      }
    } on DioException catch (error) {
      emit(
        LeadsListingError(
          exception: error,
          // TODO(kaxp) handle the error message properly
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> getFilterLeads(
    int page, {
    int? leadParentId,
  }) async {
    try {
      if (!(state is LeadsListingFilter)) {
        emit(LeadsListingFilter(leadListingData: state.leadListingData!));
      }

      final result = await _repo.getLeadsListing(
        agentMobile: agentMobileNumber,
        page: page,
        leadParentId: leadParentId,
      );

      if (result.data != null) {
        initialLeads = result.data!;
        emit(
          LeadsListingLoaded(
            leadListingData: result.data!,
          ),
        );
        final List<Lead>? leads = initialLeads?.leads?.data;

        if (leads == null || leads.isEmpty) {
          emit(
            LeadsListingEmpty(
              leadListingData: result.data!,
            ),
          );
        }
      }
    } on DioException catch (error) {
      emit(
        LeadsListingError(
          exception: error,
          // TODO(kaxp) handle the error message properly
          message: error.toString(),
        ),
      );
    }
  }
}
