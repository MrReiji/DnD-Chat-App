import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_chat_app/blocs/form_bloc/add_campaign_form_bloc_bloc.dart';
import 'package:dnd_chat_app/models/campaign.dart';
import 'package:dnd_chat_app/utils/download_image_from_URL.dart';
import 'package:dnd_chat_app/widgets/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../blocs/campaign/campaign_bloc.dart';
import '../utils/approuter_paths.dart';

import '../models/icons/dnd_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "DnD Chat App",
            style: GoogleFonts.outfit(fontSize: 30),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
          IconButton(
            onPressed: () {
              context.push(AppRouterPaths.add_campaign);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('campaigns')
            .where('creatorID',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (ctx, chatSnapshots) {
          if (chatSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Dnd_logo_dice.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    "Empty list? Add your first campaign!",
                    style: GoogleFonts.preahvihear(fontSize: 20),
                  ),
                ],
              ),
            );
          }

          if (chatSnapshots.hasError) {
            return Center(
              child: Text(
                'Something went wrong...',
                style: GoogleFonts.preahvihear(fontSize: 20),
              ),
            );
          }

          final loadedCampaigns = chatSnapshots.data!.docs;

          return ListView.builder(
            itemCount: loadedCampaigns.length,
            itemBuilder: (BuildContext context, int index) {
              final campaign = loadedCampaigns[index].data();
              final String id = loadedCampaigns[index].id;
              final String title = campaign['title'];
              final String description = campaign['description'];
              final String image_url = campaign['image_url'];
              final String creatorID = campaign['creatorID'];
              return ListTile(
                onTap: () {
                  context.push(AppRouterPaths.chat);
                },
                leading: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(image_url),
                ),
                title: Text(title),
                subtitle: Text(description),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          iconSize: 25,
                          onPressed: () async {
                            LoadingDialog();
                            final imageFile =
                                await downloadImage(Uri.parse(image_url), id);
                            context.push(AppRouterPaths.add_campaign,
                                extra: Campaign(
                                    id: id,
                                    title: title,
                                    description: description,
                                    image: imageFile,
                                    creatorID: creatorID));
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.cancel),
                          iconSize: 25,
                          onPressed: () {
                            deleteCampaignAndFile(id);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(DnDIcons.burning_book),
            label: "Campaigns",
          ),
          BottomNavigationBarItem(
            icon: Icon(DnDIcons.perspective_dice_six),
            label: "Table",
          ),
          BottomNavigationBarItem(
            icon: Icon(DnDIcons.knight_helmet),
            label: "Profile",
          ),
        ],
        onTap: (value) {},
      ),
    );
  }
}
