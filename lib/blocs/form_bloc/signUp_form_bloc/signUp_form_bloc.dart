import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class SignUpFormBloc extends FormBloc<String, String> {
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
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: email.value, password: password.value);
      print(userCredentials);
      await Future<void>.delayed(const Duration(seconds: 1));
      emitSuccess();
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        emitFailure(failureResponse: "Email already in use. Sign in!");
      } else {
        emitFailure(failureResponse: "Authentication failed");
      }
    }
  }
}
