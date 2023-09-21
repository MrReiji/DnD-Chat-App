import 'dart:io';

import 'package:dnd_chat_app/blocs/campaign/campaign_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../models/campaign.dart';
import '../../cubits/image_picker/image_picker_cubit.dart';
//import 'package:firebase_auth/firebase_auth.dart';

//final _firebase = FirebaseAuth.instance;

class AddCampaignFormBloc extends FormBloc<String, String> {
  late final CampaignBloc campaignBloc;
  bool needToUpdate = false;
  File? selectedImage;

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
    try {
      final id = DateTime.now().microsecondsSinceEpoch;

      debugPrint(title.value);
      debugPrint(description.value);
      debugPrint('$id');

      selectedImage ?? emitFailure(failureResponse: 'Add image!');
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('campaign_images')
          .child('$id.jpg');
      if (needToUpdate) {
        campaignBloc.add(UpdateCampaign(
            campaign: Campaign(
                id: '$id',
                title: title.value,
                description: description.value,
                image: selectedImage!)));
      } else {
        campaignBloc.add(AddCampaign(
            campaign: Campaign(
                id: '$id',
                title: title.value,
                description: description.value,
                image: selectedImage!)));
        await storageRef.putFile(selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();
        debugPrint(imageUrl);
      }

      emitSuccess(successResponse: 'Added with succes');
    } catch (error) {
      debugPrint(error.toString());
      emitFailure(failureResponse: 'Something\'s wrong');
    }
  }
}