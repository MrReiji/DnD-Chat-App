import 'package:dnd_chat_app/blocs/campaign/campaign_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../models/campaign.dart';
//import 'package:firebase_auth/firebase_auth.dart';

//final _firebase = FirebaseAuth.instance;

class AddCampaignFormBloc extends FormBloc<String, String> {
  late final CampaignBloc campaignBloc;
  bool needToUpdate = false;

  final title = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final description = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  AddCampaignFormBloc(this.campaignBloc) {
    addFieldBlocs(
      fieldBlocs: [
        title,
        description,
      ],
    );
  }

  @override
  void onSubmitting() async {
    debugPrint(title.value);
    debugPrint(description.value);

    try {
      if (needToUpdate) {
        print("Update");
        campaignBloc.add(UpdateCampaign(
            campaign: Campaign(
                id: '8',
                title: title.value,
                description: description.value,
                imageURL:
                    'https://www.shutterstock.com/shutterstock/photos/2208372513/display_1500/stock-vector-dice-for-playing-dnd-tabletop-role-playing-game-dungeon-and-dragons-with-d-magical-role-of-2208372513.jpg')));
      } else {
        print("AddedNew");
        campaignBloc.add(AddCampaign(
            campaign: Campaign(
                id: '8',
                title: title.value,
                description: description.value,
                imageURL:
                    'https://www.shutterstock.com/shutterstock/photos/2208372513/display_1500/stock-vector-dice-for-playing-dnd-tabletop-role-playing-game-dungeon-and-dragons-with-d-magical-role-of-2208372513.jpg')));
      }

      emitSuccess(successResponse: 'Added with succes');
      print("After this");
    } catch (error) {
      print(error);
      emitFailure(failureResponse: 'Something\'s wrong');
    }
  }
}
