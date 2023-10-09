import 'dart:io';

import 'package:dnd_chat_app/blocs/campaign/campaign_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/campaign.dart';
import '../cubits/image_picker/image_picker_cubit.dart';
//import 'package:firebase_auth/firebase_auth.dart';

//final _firebase = FirebaseAuth.instance;

class AddCampaignFormBloc extends FormBloc<String, String> {
  late final CampaignBloc campaignBloc;
  bool needToUpdate = false;
  File? selectedImage;
  String? id;

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
      id ??= DateTime.now().microsecondsSinceEpoch.toString();

      debugPrint(title.value);
      debugPrint(description.value);
      debugPrint('$id');

      selectedImage ?? emitFailure(failureResponse: 'Add image!');
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('campaign_images')
          .child('$id.jpg');

      await storageRef.putFile(selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();

      if (needToUpdate) {
        campaignBloc.add(UpdateCampaign(
            campaign: Campaign(
                id: '$id',
                title: title.value,
                description: description.value,
                image: selectedImage!)));

        await FirebaseFirestore.instance
            .collection('campaigns')
            .doc('$id')
            .update({
          'title': title.value,
          'description': description.value,
          'image_url': await storageRef.getDownloadURL(),
        });
      } else {
        campaignBloc.add(AddCampaign(
            campaign: Campaign(
                id: '$id',
                title: title.value,
                description: description.value,
                image: selectedImage!)));

        debugPrint(imageUrl);

        await FirebaseFirestore.instance
            .collection('campaigns')
            .doc('$id')
            .set({
          'title': title.value,
          'description': description.value,
          'image_url': imageUrl,
        });
      }

      emitSuccess(successResponse: 'Added with succes');
    } catch (error) {
      debugPrint(error.toString());
      emitFailure(failureResponse: 'Something\'s wrong');
    }
  }
}
