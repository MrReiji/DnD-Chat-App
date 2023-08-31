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
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: email.value, password: password.value);
      print(userCredentials);
      await Future<void>.delayed(const Duration(seconds: 1));
      emitSuccess();
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        emitFailure(failureResponse: "Email already in use");
      } else {
        emitFailure(failureResponse: "Authentication failed");
      }
      // ScaffoldMessenger.of(context).clearSnackBars();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(error.message ?? 'Authentication failed.'),
      //   ),
      // );
    }

    // if (showSuccessResponse.value) {
    //   emitSuccess();
    // } else {
    //   emitFailure(failureResponse: 'This is an awesome error!');
    // }
  }
}
