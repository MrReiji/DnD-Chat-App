import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/campaign.dart';
import '../../widgets/loading_dialog.dart';

class AddParticipantsFormBloc extends FormBloc<String, String> {
  final username = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  late final String id;
  late final List<String> participants;

  AddParticipantsFormBloc({id, participants})
      : this.id = id,
        this.participants = participants {
    addFieldBlocs(fieldBlocs: [username]);
    username.addAsyncValidators([_validateUsernameNotInParticipants]);
  }

  // Validator to check if username is in the participants list
  Future<String?> _validateUsernameNotInParticipants(String? username) async {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    // Fetch the campaign from Firestore
    // Check if the username is already a participant
    var userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();
    if (userSnapshot.docs.isEmpty) {
      return 'User not found';
    }
    var userId = userSnapshot.docs.first.id;
    if (participants!.contains(userId)) {
      return 'User is already a participant';
    } else {
      return null;
    }
  }

  @override
  void onSubmitting() async {
    try {
      // Get the user document ID by the username
      var userQuerySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username.value.trim())
          .limit(1)
          .get();

      if (userQuerySnapshot.docs.isEmpty) {
        emitFailure(failureResponse: 'User not found');
        return;
      }
      var userId = userQuerySnapshot.docs.first.id;

      // Get the campaign document
      var campaignDocRef =
          FirebaseFirestore.instance.collection('campaigns').doc(id);
      var campaignSnapshot = await campaignDocRef.get();

      if (!campaignSnapshot.exists) {
        emitFailure(failureResponse: 'Campaign not found');
        return;
      }

      // Update the participants array
      // await FirebaseFirestore.instance.runTransaction((transaction) async {
      //   var freshSnapshot = await transaction.get(campaignDocRef);
      //   var freshParticipants =
      //       List<String>.from(freshSnapshot.data()?['participants'] ?? []);
      //   if (!freshParticipants.contains(userId)) {
      //     freshParticipants.add(userId);
      //     transaction
      //         .update(campaignDocRef, {'participants': freshParticipants});
      //   }
      // });

      participants.add(userId);

      await FirebaseFirestore.instance.collection('campaigns').doc(id).update({
        'participants': participants,
      });

      emitSuccess(successResponse: 'User added to participants!');
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }
}
