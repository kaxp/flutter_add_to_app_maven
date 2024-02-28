import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_detail_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/repositories/leads_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

part 'lead_detail_state.dart';

class LeadDetailBloc extends Cubit<LeadDetailState> {
  LeadDetailBloc() : super(LeadDetailInitial());

  final _repo = LeadsRepo();

  Future<void> getLeadDetails(int leadId) async {
    try {
      emit(LeadDetailLoading());

      final result = await _repo.getLeadDetailById(
        leadId: leadId,
      );

      if (result.data != null) {
        emit(
          LeadDetailLoaded(
            leadDetailData: result.data!,
          ),
        );
      }
    } on DioException catch (error) {
      emit(
        LeadDetailError(
          exception: error,
          // TODO(kaxp) handle the error message properly
          message: error.message ?? error.toString(),
        ),
      );
    }
  }
}
