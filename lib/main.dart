import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dnd_chat_app/blocs/campaign/campaign_bloc.dart';
import 'package:dnd_chat_app/utils/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'blocs/cubits/image_picker/image_picker_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CampaignBloc(),
        ),
        BlocProvider(
          create: (context) => ImagePickerCubit(),
        ),
      ],
      child: MaterialApp.router(
        routerDelegate: AppRouter.router.routerDelegate,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        title: 'DnD Chat App',
        theme: ThemeData.dark().copyWith(
          colorScheme: ThemeData.dark().colorScheme.copyWith(
                secondary: Colors.lightBlueAccent,
              ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
