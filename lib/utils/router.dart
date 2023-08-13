import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:overlapping_panels_demo/screens/add_campaign_screen.dart';

import '../models/campaign.dart';
import '../screens/home_screen.dart';
import 'approuter_paths.dart';

class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRouterPaths.home,
    routes: [
      GoRoute(
          name: 'home',
          path: AppRouterPaths.home,
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
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
    ],
  );
}
