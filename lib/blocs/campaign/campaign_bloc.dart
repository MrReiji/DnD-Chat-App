import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/campaign.dart';

part 'campaign_event.dart';
part 'campaign_state.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  CampaignBloc() : super(CampaignInitial()) {
    on<LoadCampaigns>((event, emit) {
      emit(CampaignLoaded(campaigns: event.campaigns));
    });

    on<AddCampaign>((event, emit) {
      final state = this.state;
      final List<Campaign> campaigns = (state is CampaignLoaded)
          ? (List.from(state.campaigns)..add(event.campaign))
          : [event.campaign];
      emit(CampaignLoaded(campaigns: campaigns));
    });

    on<UpdateCampaign>((event, emit) {
      final state = this.state;
      if (state is CampaignLoaded) {
        List<Campaign> campaigns = (state.campaigns.map((campaign) {
          return campaign.id == event.campaign.id ? event.campaign : campaign;
        })).toList();
        emit(CampaignLoaded(campaigns: campaigns));
      }
    });

    on<DeleteCampaign>((event, emit) {
      final state = this.state;
      if (state is CampaignLoaded) {
        List<Campaign> campaigns = (state.campaigns.where((campaign) {
          return campaign.id != event.campaign.id;
        })).toList();
        if (campaigns.isEmpty) {
          emit(CampaignInitial());
        } else {
          emit(CampaignLoaded(campaigns: campaigns));
        }
      }
    });
  }
}
