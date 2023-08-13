import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlapping_panels_demo/blocs/campaign/campaign_bloc.dart';
import 'package:overlapping_panels_demo/models/campaign.dart';
import 'package:overlapping_panels_demo/screens/home_screen.dart';
import 'package:overlapping_panels_demo/utils/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CampaignBloc(),
        child: MaterialApp.router(
          routerDelegate: AppRouter.router.routerDelegate,
          routeInformationParser: AppRouter.router.routeInformationParser,
          routeInformationProvider: AppRouter.router.routeInformationProvider,
          title: 'DnD Chat App',
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          // child: MaterialApp(
          //     title: 'DnD Chat App',
          //     theme: ThemeData.dark(),
          //     debugShowCheckedModeBanner: false,
          //     home: HomeScreen()),
        ));
  }
}
