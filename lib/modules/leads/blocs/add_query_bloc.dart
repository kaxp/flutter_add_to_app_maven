import 'dart:io';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_query_options_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/repositories/leads_repo.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'add_query_state.dart';

class AddQueryBloc extends Cubit<AddQueryState> {
  AddQueryBloc() : super(AddQueryInitial());

  List<QueryType>? queriesOptions;
  final _repo = LeadsRepo();

  Future<void> getQueriesOptions() async {
    // Early exit in case queriesOptions is not null
    if (queriesOptions != null) {
      emit(
        LeadQueryOptionsLoaded(
          queriesOptions: queriesOptions,
          fieldError: false,
        ),
      );
      return;
    }

    try {
      emit(AddQueryLoading());
      final result = await _repo.getQueriesOptions();

      if (result.data != null) {
        queriesOptions = result.data;
        emit(
          LeadQueryOptionsLoaded(queriesOptions: queriesOptions),
        );
      }
    } on DioException {}
  }

  void onTextFieldTap() {
    emit(
      LeadQueryOptionsLoaded(
        queriesOptions: queriesOptions,
        fieldError: false,
      ),
    );
  }

  Future<void> onSubmitTap({
    required int leadId,
    required String query,
    required String queryType,
    required List<File> files,
    required TextEditingController textController,
  }) async {
    if (textController.text.isEmpty) {
      emit(
        LeadQueryOptionsLoaded(
          queriesOptions: queriesOptions,
          fieldError: true,
        ),
      );
      return;
    }

    try {
      emit(AddQuerySubmitLoading());
      final result = await _repo.submitQuery(
        leadId: leadId,
        comment: query,
        filenames: files,
        queryType: queryType,
      );

      if (result.data != null) {
        emit(AddQuerySubmited());
      } else {
        emit(AddQuerySubmitError());
      }
    } on DioException {
      //TODO: Emit error state
    }
  }
}
