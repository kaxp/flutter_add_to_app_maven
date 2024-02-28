import 'dart:io';
import 'package:kapil_add_to_app_flutter/modules/leads/models/lead_query_response.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/repositories/leads_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

part 'lead_queries_state.dart';

class LeadQueriesBloc extends Cubit<LeadQueriesState> {
  LeadQueriesBloc() : super(LeadQueryInitial());

  final _repo = LeadsRepo();

  Future<void> getLeadQueries(int leadId) async {
    try {
      emit(LeadQueryLoading());

      final result = await _repo.getLeadQueries(
        leadId: leadId,
      );

      if (result.data != null) {
        emit(
          LeadQueryLoaded(
            leadQueryData: result.data!,
            selectedFiles: state.selectedFiles!,
          ),
        );
      }
    } on DioException catch (error) {
      emit(
        LeadQueryError(
          exception: error,
          // TODO(kaxp) handle the error message properly
          message: error.message ?? error.toString(),
        ),
      );
    }
  }

  Future<void> refreshQueries(int leadId) async {
    try {
      final result = await _repo.getLeadQueries(
        leadId: leadId,
      );

      if (result.data != null) {
        emit(
          LeadQueryLoaded(
            leadQueryData: result.data!,
            selectedFiles: state.selectedFiles!,
          ),
        );
      }
    } on DioException {}
  }

  Future<void> submitQuery(
      {required int leadId,
      required String query,
      required String queryType,
      required List<File> files}) async {
    try {
      emit(
        LeadQuerySendLoading(
            leadQueryData: state.leadQueryData!,
            selectedFiles: state.selectedFiles!),
      );

      final result = await _repo.submitQuery(
        leadId: leadId,
        comment: query,
        filenames: files,
        queryType: queryType,
      );

      if (result.data != null) {
        refreshQueries(leadId);
      }
    } on DioException {}
  }

  void onSubmitTap(
      {required int leadId,
      required String query,
      required String queryType,
      required List<File>? files}) {
    submitQuery(
      leadId: leadId,
      query: query,
      queryType: queryType,
      files: files ?? [],
    );
  }

/*
  Future<void> onPickerTap() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'pdf',
        'png',
      ],
    );
    final List<File> files = [];
    if (result != null) {
      for (var i in result.paths) {
        if (i != null) {
          files.add(File(i));
        }
      }
    }
    List<File>? selectedFiles = state.selectedFiles;
    selectedFiles!.addAll(files);

    emit(
      LeadQueryLoaded(
        leadQueryData: state.leadQueryData!,
        selectedFiles: files,
      ),
    );
  }

  Future<void> openFile(String? url,{int? index,int? position,bool isImage=false})
  async {
    if (url == null) return;
    final String fileName = url.fileName();
    String? downloadPath;
    File? file;

    if (await Permission.storage.request().isGranted) {
      downloadPath = (await DownloadsPath.downloadsDirectory())?.path ?? '';
      final bool fileExits = File('$downloadPath/$fileName').existsSync();

      if (!fileExits) {
        await FlDownloader.download(
          url,
          fileName: fileName,
        );
       */ /* if (index != null && position != null) {
          if (isImage) {
            state.leadQueryData = state.leadQueryData?.queries![index].documentImage![position].is_downloaded = true;
            commentsList[index].documentImage![position].isDownloaded=true;
          } else {
            commentsList[index].documentFile![position].isDownloaded=true;
          }
        }
        _commentsList.refresh();*/ /*
        // TODO : apply logic
      }else {
       */ /* if (index != null && position != null) {
          if (isImage) {
            commentsList[index].documentImage![position].isDownloaded=true;
          } else {
            commentsList[index].documentFile![position].isDownloaded=true;
          }
        }
        _commentsList.refresh();*/ /*
        // TODO : apply logic
      }
      file = File('$downloadPath/$fileName');

      if (file.path.isNotEmpty && downloadPath.isNotEmpty) {
        // await OpenFilex.open(file.path);
      }
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      // Fluttertoast.showToast(msg: permission_denied.tr);
    }
  }*/
}
