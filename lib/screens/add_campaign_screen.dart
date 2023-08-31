import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dnd_chat_app/blocs/campaign/campaign_bloc.dart';
import 'package:dnd_chat_app/blocs/cubits/cubit/text_form_field_cubit.dart';
import 'package:dnd_chat_app/models/campaign.dart';
import 'package:dnd_chat_app/utils/faker.dart';

class AddCampaignScreen extends StatelessWidget {
  const AddCampaignScreen({this.campaignBeforeEdit, Key? key})
      : super(key: key);

  final Campaign? campaignBeforeEdit;

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId =
        TextEditingController(text: campaignBeforeEdit?.id ?? '');
    TextEditingController controllerTitle =
        TextEditingController(text: campaignBeforeEdit?.title ?? '');
    TextEditingController controllerDescription =
        TextEditingController(text: campaignBeforeEdit?.description ?? '');
    TextEditingController controllerImage =
        TextEditingController(text: campaignBeforeEdit?.imageURL ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "DnD Chat App",
            style: GoogleFonts.outfit(fontSize: 30),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => TextFormFieldCubit(),
        child: BlocBuilder<TextFormFieldCubit, bool>(
          builder: (ctx, isReadyToClick) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _inputField('ID', controllerId, ctx, controllerId,
                        controllerTitle, controllerDescription),
                    _inputField('Title', controllerTitle, ctx, controllerId,
                        controllerTitle, controllerDescription),
                    _inputField('Description', controllerDescription, ctx,
                        controllerId, controllerTitle, controllerDescription),
                    _inputField('Image', controllerImage, ctx, controllerId,
                        controllerTitle, controllerDescription),
                    ElevatedButton(
                      onPressed: isReadyToClick
                          ? () => _onButtonPressed(
                                context,
                                controllerId,
                                controllerTitle,
                                controllerDescription,
                                controllerImage,
                              )
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Text(campaignBeforeEdit == null
                          ? 'Add new campaign'
                          : 'Update campaign'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onButtonPressed(
    BuildContext context,
    TextEditingController controllerId,
    TextEditingController controllerTitle,
    TextEditingController controllerDescription,
    TextEditingController controllerImage,
  ) {
    // Create a new Campaign instance
    var campaign = Campaign(
      id: controllerId.text,
      title: controllerTitle.text,
      description: controllerDescription.text,
      imageURL: controllerImage.text.isEmpty
          ? AppFaker().generatePlaceholderImage()
          : controllerImage.text,
    );

    if (campaignBeforeEdit != null) {
      // Update the campaign
      context.read<CampaignBloc>().add(UpdateCampaign(campaign: campaign));
    } else {
      // Add a new campaign
      context.read<CampaignBloc>().add(AddCampaign(campaign: campaign));
    }

    // Close the screen
    context.pop();
  }

  Column _inputField(
    String field,
    TextEditingController controller,
    BuildContext ctx,
    TextEditingController controllerId,
    TextEditingController controllerTitle,
    TextEditingController controllerDescription,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$field: ',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          child: TextFormField(
            controller: controller,
            onChanged: (_) {
              ctx.read<TextFormFieldCubit>().checkIfReady(
                    controllerId,
                    controllerTitle,
                    controllerDescription,
                  );
            },
          ),
        ),
      ],
    );
  }
}
