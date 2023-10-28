import 'package:dnd_chat_app/screens/sign_up_screen.dart';
import 'package:dnd_chat_app/utils/router_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dnd_chat_app/screens/add_campaign_screen.dart';

import '../models/campaign.dart';
import '../screens/auth_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/home_screen.dart';
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
          name: 'sign_up',
          path: AppRouterPaths.sign_up,
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpScreen();
          }),
      GoRoute(
          name: 'chat',
          path: AppRouterPaths.chat,
          builder: (BuildContext context, GoRouterState state) {
            return const ChatScreen();
          }),
    ],
  );
}
