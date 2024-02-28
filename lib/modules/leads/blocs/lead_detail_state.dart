part of 'lead_detail_bloc.dart';

abstract class LeadDetailState extends Equatable {
  const LeadDetailState({
    this.leadDetailData,
  });

  final LeadDetailData? leadDetailData;

  List<Object?> get props => [leadDetailData];
}

class LeadDetailInitial extends LeadDetailState {}

class LeadDetailLoading extends LeadDetailState {}

class LeadDetailEmpty extends LeadDetailState {}

class LeadDetailLoaded extends LeadDetailState {
  const LeadDetailLoaded({
    required LeadDetailData leadDetailData,
  }) : super(leadDetailData: leadDetailData);
}

class LeadDetailError extends LeadDetailState {
  const LeadDetailError({
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
