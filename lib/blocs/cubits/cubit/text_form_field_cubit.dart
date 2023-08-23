import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class TextFormFieldCubit extends Cubit<bool> {
  TextFormFieldCubit() : super(false);

  void checkIfReady(
    TextEditingController controllerId,
    TextEditingController controllerTitle,
    TextEditingController controllerDescription,
  ) {
    bool isReady = controllerId.text.isNotEmpty &&
        controllerTitle.text.isNotEmpty &&
        controllerDescription.text.isNotEmpty;
    emit(isReady);
  }
}
