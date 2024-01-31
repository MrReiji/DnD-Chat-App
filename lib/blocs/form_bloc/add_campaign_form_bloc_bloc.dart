import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

//import 'package:firebase_auth/firebase_auth.dart';

//final _firebase = FirebaseAuth.instance;

class AddCampaignFormBloc extends FormBloc<String, String> {
  //late final CampaignBloc campaignBloc;
  bool needToUpdate = false;
  File? selectedImage;
  String? id;
  final String creatorID = FirebaseAuth.instance.currentUser!.uid;

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

  AddCampaignFormBloc(/*this.campaignBloc*/) {
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
        // campaignBloc.add(UpdateCampaign(
        //     campaign: Campaign(
        //         id: '$id',
        //         title: title.value,
        //         description: description.value,
        //         image: selectedImage!,
        //         creatorID: creatorID)));

        await FirebaseFirestore.instance
            .collection('campaigns')
            .doc('$id')
            .update({
          'title': title.value,
          'description': description.value,
          'image_url': await storageRef.getDownloadURL(),
        });
      } else {
        // campaignBloc.add(AddCampaign(
        //     campaign: Campaign(
        //         id: '$id',
        //         title: title.value,
        //         description: description.value,
        //         image: selectedImage!,
        //         creatorID: creatorID)));

        debugPrint(imageUrl);

        await FirebaseFirestore.instance
            .collection('campaigns')
            .doc('$id')
            .set({
          'title': title.value,
          'description': description.value,
          'image_url': imageUrl,
          'creatorID': creatorID,
          'participants': [creatorID]
        });
      }

      emitSuccess(successResponse: 'Added with succes');
    } catch (error) {
      debugPrint(error.toString());
      emitFailure(failureResponse: 'Something\'s wrong');
    }
  }
}

Future<void> deleteCampaignAndFile(String id) async {
  try {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('campaign_images')
        .child('$id.jpg');

    // Delete the file from Firebase Storage
    await storageRef.delete();
    debugPrint('File deleted successfully: $id.jpg');

    // Delete the document from Firestore
    await FirebaseFirestore.instance.collection('campaigns').doc(id).delete();
    debugPrint('Document deleted successfully: $id');

    debugPrint('Campaign with ID $id deleted successfully.');
  } catch (e) {
    debugPrint('Error deleting campaign and file: $e');
  }
}
