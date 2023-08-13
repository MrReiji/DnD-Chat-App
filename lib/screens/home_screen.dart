import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../blocs/campaign/campaign_bloc.dart';
import '../utils/approuter_paths.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CampaignBloc, CampaignState>(
        builder: (context, state) {
          if (state is CampaignInitial) {
            return Center(
                child: Image.asset(
              'assets\\Dnd_logo.png', // Adres URL obrazu
              width: 200, // Opcjonalnie, ustaw szerokość obrazu
              height: 200, // Opcjonalnie, ustaw wysokość obrazu
              fit: BoxFit.cover, // Opcjonalnie, dopasowanie obrazu
            ));
          } else if (state is CampaignLoaded) {
            return ListView.builder(
                itemCount: state.campaigns.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(state.campaigns[index].imageURL)),
                    title: Text(state.campaigns[index].title),
                    subtitle: Text(state.campaigns[index].description),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              iconSize: 25,
                              onPressed: () {
                                context.push(AppRouterPaths.add_campaign,
                                    extra: state.campaigns[index]);
                                // context.read<CampaignBloc>().add(UpdateCampaign(
                                //     campaign: state.campaigns[index]));
                              },
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: Icon(Icons.cancel),
                              iconSize: 25,
                              onPressed: () {
                                context.read<CampaignBloc>().add(DeleteCampaign(
                                    campaign: state.campaigns[index]));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  );
                });
          } else {
            return Text("Nie dziala");
          }
        },
      ),
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
                context.push(AppRouterPaths.add_campaign);

                // context.read<CampaignBloc>().add(
                //       AddCampaign(
                //         campaign: Campaign(
                //           id: 1,
                //           title: "Tytul",
                //           description: "Opis",
                //           image: Image.network(
                //               "https://w7.pngwing.com/pngs/172/385/png-transparent-d20-dice-game-nat20-dnd-d-d-critical-hit-crit-polyhedral-rpg.png"),
                //         ),
                //       ),
                //     );
              },
              icon: Icon(Icons.add))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            label: "Channels",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Profile",
          ),
        ],
        onTap: (value) {},
      ),
    );
  }
}