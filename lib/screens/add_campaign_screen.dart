import 'dart:io';

import 'package:dnd_chat_app/blocs/form_bloc/add_campaign_form_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dnd_chat_app/blocs/campaign/campaign_bloc.dart';
import 'package:dnd_chat_app/models/campaign.dart';
import 'package:dnd_chat_app/utils/faker.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/cubits/image_picker/image_picker_cubit.dart';
import '../models/image_picker.dart';
import '../utils/approuter_paths.dart';
import '../widgets/loading_dialog.dart';

class AddCampaignScreen extends StatelessWidget {
  const AddCampaignScreen({this.campaignBeforeEdit, Key? key})
      : super(key: key);

  final Campaign? campaignBeforeEdit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCampaignFormBloc(context.read<CampaignBloc>()),
      child: Builder(builder: (context) {
        final addCampaignFormBloc = context.read<AddCampaignFormBloc>();
        if (campaignBeforeEdit != null) {
          addCampaignFormBloc.title.updateValue(campaignBeforeEdit!.title);
          addCampaignFormBloc.description
              .updateValue(campaignBeforeEdit!.description);
          addCampaignFormBloc.selectedImage = campaignBeforeEdit!.image;
          addCampaignFormBloc.id = campaignBeforeEdit!.id;
          context.read<ImagePickerCubit>().setImage(campaignBeforeEdit!.image);
          addCampaignFormBloc.needToUpdate = true;
        } else {
          context.read<ImagePickerCubit>().clearImage();
        }

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Center(
              child: Text(
                "DnD Chat App",
                style: GoogleFonts.outfit(fontSize: 30),
              ),
            ),
          ),
          body: FormBlocListener<AddCampaignFormBloc, String, String>(
            onSubmitting: (context, state) {
              LoadingDialog.show(context);
            },
            onSubmissionFailed: (context, state) {
              LoadingDialog.hide(context);
            },
            onSuccess: (context, state) {
              LoadingDialog.hide(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.successResponse!)));

              context.go(AppRouterPaths.home);
            },
            onFailure: (context, state) {
              LoadingDialog.hide(context);

              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.failureResponse!)));
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: AutofillGroup(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ImagePickerWidget(
                          onPickImage: (pickedImage) {
                            addCampaignFormBloc.selectedImage = pickedImage;
                          },
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: addCampaignFormBloc.title,
                          keyboardType: TextInputType.text,
                          // autofillHints: const [
                          //   AutofillHints.name,
                          // ],
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            prefixIcon: Icon(Icons.title),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: addCampaignFormBloc.description,
                          keyboardType: TextInputType.text,
                          // autofillHints: const [
                          //   AutofillHints.name,
                          // ],
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            prefixIcon: Icon(Icons.description_rounded),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: addCampaignFormBloc.submit,
                          child: Text(campaignBeforeEdit == null
                              ? 'Add campaign'
                              : 'Update campaign'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
