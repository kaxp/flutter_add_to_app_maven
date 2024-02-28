part of 'leads_listing_bloc.dart';

abstract class LeadsListingState extends Equatable {
  const LeadsListingState({
    this.leadListingData,
    this.leadsParentId,
  });

  final LeadListingData? leadListingData;
  final int? leadsParentId;

  @override
  List<Object?> get props => [leadListingData];
}

class LeadsListingInitial extends LeadsListingState {}

class LeadsListingLoading extends LeadsListingState {}

class LeadsListingEmpty extends LeadsListingState {
  const LeadsListingEmpty({
    required LeadListingData leadListingData,
  }) : super(
          leadListingData: leadListingData,
        );
}

class LeadsListingLoaded extends LeadsListingState {
  const LeadsListingLoaded({
    required LeadListingData leadListingData,
  }) : super(
          leadListingData: leadListingData,
        );
}

class LeadsListingLoadMore extends LeadsListingState {
  const LeadsListingLoadMore({
    required LeadListingData leadListingData,
  }) : super(leadListingData: leadListingData);
}

class LeadsListingFilter extends LeadsListingState {
  const LeadsListingFilter({
    required LeadListingData leadListingData,
  }) : super(leadListingData: leadListingData);
}

class LeadsListingError extends LeadsListingState {
  const LeadsListingError({
    required this.exception,
    required this.message,
  });

  final Object? exception;
  final String message;

  @override
  List<Object?> get props => [
        exception,
        message,
        ...super.props,
      ];
}
