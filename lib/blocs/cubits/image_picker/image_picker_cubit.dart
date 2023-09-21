import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerCubit extends Cubit<File?> {
  ImagePickerCubit() : super(null);

  void setImage(File image) => emit(image);

  void clearImage() => emit(null);
}
