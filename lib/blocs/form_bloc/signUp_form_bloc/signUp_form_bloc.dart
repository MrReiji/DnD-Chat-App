import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class SignUpFormBloc extends FormBloc<String, String> {
  File? selectedImage;

  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.passwordMin6Chars,
    ],
  );

  final username = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  SignUpFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        email,
        password,
        username,
      ],
    );
  }

  @override
  void onSubmitting() async {
    debugPrint(email.value);
    debugPrint(password.value);
    debugPrint(username.value);

    try {
      if (selectedImage == null) throw SelectedImageIsNullException();

      final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: email.value, password: password.value);
      debugPrint(userCredentials.toString());

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child(userCredentials.user!.uid);

      await storageRef.putFile(selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();
      debugPrint(imageUrl);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set({
        'username': username.value,
        'email': email.value,
        'image_url': imageUrl,
      });
      emitSuccess();
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        emitFailure(failureResponse: "Email already in use. Sign in!");
      } else {
        emitFailure(failureResponse: "Authentication failed");
      }
    } on SelectedImageIsNullException {
      emitFailure(failureResponse: 'Add image!');
    }
  }
}

class SelectedImageIsNullException implements Exception {}
