import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class LoginFormBloc extends FormBloc<String, String> {
  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  LoginFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        email,
        password,
      ],
    );
  }

  @override
  void onSubmitting() async {
    debugPrint(email.value);
    debugPrint(password.value);

    try {
      final userCredentials = await _firebase.signInWithEmailAndPassword(
          email: email.value, password: password.value);
      print(userCredentials);
      await Future<void>.delayed(const Duration(seconds: 1));
      emitSuccess();
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        emitFailure(failureResponse: "User not found. Create an account!");
      } else {
        emitFailure(failureResponse: "Authentication failed");
      }
    }
  }
}
