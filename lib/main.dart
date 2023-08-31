import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dnd_chat_app/blocs/campaign/campaign_bloc.dart';
import 'package:dnd_chat_app/utils/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
