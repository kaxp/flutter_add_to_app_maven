part of 'add_query_bloc.dart';

abstract class AddQueryState extends Equatable {
  const AddQueryState({
    this.fieldError,
    this.queriesOptions,
  });

  final List<QueryType>? queriesOptions;
  final bool? fieldError;

  List<Object?> get props => [queriesOptions, fieldError];
}

class AddQueryInitial extends AddQueryState {}

class AddQueryLoading extends AddQueryState {}

class AddQueryEmpty extends AddQueryState {}

class LeadQueryOptionsLoaded extends AddQueryState {
  const LeadQueryOptionsLoaded({
    required List<QueryType>? queriesOptions,
    bool? fieldError,
  }) : super(
          queriesOptions: queriesOptions,
          fieldError: fieldError,
        );
}

class AddQueryError extends AddQueryState {
  const AddQueryError({
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

class AddQuerySubmitLoading extends AddQueryState {}

class AddQuerySubmited extends AddQueryState {}

class AddQuerySubmitError extends AddQueryState {}
