import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class ChatFormBloc extends FormBloc<String, String> {
  final text = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final user = FirebaseAuth.instance.currentUser!;
  final String id;

  ChatFormBloc(this.id) {
    addFieldBlocs(
      fieldBlocs: [
        text,
      ],
    );
  }

  @override
  void onSubmitting() async {
    debugPrint(text.value);
    try {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      FirebaseFirestore.instance
          .collection('campaigns')
          .doc(id)
          .collection('chat')
          .add({
        'text': text.value,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
        'username': userData.data()!['username'],
        'userImage': userData.data()!['image_url'],
      });

      emitSuccess();
      text.updateValue('');
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
