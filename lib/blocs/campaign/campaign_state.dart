part of 'campaign_bloc.dart';

sealed class CampaignState extends Equatable {
  const CampaignState();

  @override
  List<Object> get props => [];
}

class CampaignInitial extends CampaignState {}

class CampaignLoaded extends CampaignState {
  final List<Campaign> campaigns;

  const CampaignLoaded({
    this.campaigns = const <Campaign>[],
  });

  @override
  List<Object> get props => [campaigns];
}

class CampaignError extends CampaignState {}
