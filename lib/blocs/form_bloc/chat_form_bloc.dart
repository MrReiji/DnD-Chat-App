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

  ChatFormBloc() {
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
      emitSuccess();
      text.updateValue('');
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
