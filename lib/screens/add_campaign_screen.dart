import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlapping_panels_demo/blocs/campaign/campaign_bloc.dart';
import 'package:overlapping_panels_demo/models/campaign.dart';
import 'package:overlapping_panels_demo/utils/faker.dart';

class AddCampaignScreen extends StatelessWidget {
  final Campaign? campaignBeforeEdit;

  const AddCampaignScreen({this.campaignBeforeEdit, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTitle = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();
    TextEditingController controllerImage = TextEditingController();

    controllerId.text = campaignBeforeEdit?.id ?? '';
    controllerTitle.text = campaignBeforeEdit?.title ?? '';
    controllerDescription.text = campaignBeforeEdit?.description ?? '';
    controllerImage.text = campaignBeforeEdit?.imageURL ?? '';
    bool isUpdated = campaignBeforeEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "DnD Chat App",
            style: GoogleFonts.outfit(fontSize: 30),
          ),
        ),
      ),
      body: BlocBuilder<CampaignBloc, CampaignState>(
        builder: (context, state) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _inputField('ID', controllerId),
                  _inputField('Title', controllerTitle),
                  _inputField('Description', controllerDescription),
                  _inputField('Image', controllerImage),
                  ElevatedButton(
                    onPressed: () {
                      var campaign = Campaign(
                          id: controllerId.value.text,
                          title: controllerTitle.value.text,
                          description: controllerDescription.value.text,
                          imageURL: controllerImage.value.text == ''
                              ? AppFaker().generatePlaceholderImage()
                              : controllerImage.value.text);
                      print(isUpdated);
                      if (isUpdated) {
                        context
                            .read<CampaignBloc>()
                            .add(UpdateCampaign(campaign: campaign));
                      } else {
                        context
                            .read<CampaignBloc>()
                            .add(AddCampaign(campaign: campaign));
                      }
                      context.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: const Text('Add new campaign'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Column _inputField(
    String field,
    TextEditingController controller,
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
          ),
        ),
      ],
    );
  }
}
