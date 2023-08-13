part of 'campaign_bloc.dart';

sealed class CampaignEvent extends Equatable {
  const CampaignEvent();

  @override
  List<Object> get props => [];
}

class LoadCampaigns extends CampaignEvent {
  final List<Campaign> campaigns;

  const LoadCampaigns({
    this.campaigns = const <Campaign>[],
  });

  @override
  List<Object> get props => [campaigns];
}

class AddCampaign extends CampaignEvent {
  final Campaign campaign;

  const AddCampaign({
    required this.campaign,
  });

  @override
  List<Object> get props => [campaign];
}

class UpdateCampaign extends CampaignEvent {
  final Campaign campaign;

  const UpdateCampaign({
    required this.campaign,
  });

  @override
  List<Object> get props => [campaign];
}

class DeleteCampaign extends CampaignEvent {
  final Campaign campaign;

  const DeleteCampaign({
    required this.campaign,
  });

  @override
  List<Object> get props => [campaign];
}
