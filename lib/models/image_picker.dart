import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/cubits/image_picker/image_picker_cubit.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    Key? key,
    required this.onPickImage,
  }) : super(key: key);

  final void Function(File pickedImage) onPickImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        BlocBuilder<ImagePickerCubit, File?>(
          builder: (context, pickedImageFile) {
            return CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              foregroundImage:
                  pickedImageFile != null ? FileImage(pickedImageFile) : null,
            );
          },
        ),
        TextButton.icon(
          onPressed: () => _pickImage(context),
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  void _pickImage(BuildContext context) async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    final pickedImageFile = File(pickedImage.path);
    onPickImage(pickedImageFile);
    context.read<ImagePickerCubit>().setImage(pickedImageFile);
  }
}
