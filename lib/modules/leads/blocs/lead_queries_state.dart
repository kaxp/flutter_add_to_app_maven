part of 'lead_queries_bloc.dart';

abstract class LeadQueriesState extends Equatable {
  const LeadQueriesState({
    this.leadQueryData,
    this.selectedFiles = const [],
  });

  final LeadQueryData? leadQueryData;
  final List<File>? selectedFiles;

  List<Object?> get props => [leadQueryData];
}

class LeadQueryInitial extends LeadQueriesState {}

class LeadQueryLoading extends LeadQueriesState {}

class LeadQuerySendLoading extends LeadQueriesState {
  const LeadQuerySendLoading({
    required LeadQueryData leadQueryData,
    required List<File> selectedFiles,
  }) : super(leadQueryData: leadQueryData,selectedFiles: selectedFiles);
}

class LeadQueryEmpty extends LeadQueriesState {}

class LeadQueryLoaded extends LeadQueriesState {
  const LeadQueryLoaded({
    required LeadQueryData leadQueryData,
    required List<File> selectedFiles,
  }) : super(leadQueryData: leadQueryData,selectedFiles: selectedFiles);
}

class LeadQueryError extends LeadQueriesState {
  const LeadQueryError({
    required this.exception,
    required this.message,
  });

  final Object? exception;
  final String message;

  List<Object?> get props => [
    exception,
    message,
    ...super.props,
  ];
}
