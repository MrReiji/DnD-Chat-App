import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:dnd_chat_app/models/campaign.dart';
import 'package:dnd_chat_app/screens/add_campaign_screen.dart';
import 'package:dnd_chat_app/screens/add_participants_screen.dart';
import 'package:dnd_chat_app/screens/auth_screen.dart';
import 'package:dnd_chat_app/screens/chat_screen.dart';
import 'package:dnd_chat_app/screens/home_screen.dart';
import 'package:dnd_chat_app/screens/sign_up_screen.dart';
import 'package:dnd_chat_app/utils/router_notifier.dart';

import 'approuter_paths.dart';

class AppRouter {
  static final router = GoRouter(
    refreshListenable: RouterNotifier(),
    redirect: RouterNotifier().redirect,
    debugLogDiagnostics: true,
    initialLocation: AppRouterPaths.auth,
    routes: [
      GoRoute(
          name: 'home',
          path: AppRouterPaths.home,
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          }),
      GoRoute(
          name: 'auth',
          path: AppRouterPaths.auth,
          builder: (BuildContext context, GoRouterState state) {
            return const AuthScreen();
          }),
      GoRoute(
          name: 'add_campaign',
          path: AppRouterPaths.add_campaign,
          builder: (BuildContext context, GoRouterState state) {
            Campaign? campaignBeforeEdit = state.extra as Campaign?;
            return AddCampaignScreen(
              campaignBeforeEdit: campaignBeforeEdit,
            );
          }),
      GoRoute(
          name: 'add_participants',
          path: AppRouterPaths.add_participants,
          builder: (BuildContext context, GoRouterState state) {
            final stateParam = state.extra as List<Object>;
            final String id = stateParam[0] as String;
            final List<String> participants = stateParam[1] as List<String>;
            return AddParticipantsScreen(
              id: id,
              participants: participants,
            );
          }),
      GoRoute(
          name: 'sign_up',
          path: AppRouterPaths.sign_up,
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpScreen();
          }),
      GoRoute(
          name: 'chat',
          path: AppRouterPaths.chat,
          builder: (BuildContext context, GoRouterState state) {
            final String id = state.extra as String;
            return ChatScreen(id: id);
          }),
    ],
  );
}
