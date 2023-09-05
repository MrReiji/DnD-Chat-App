import 'package:dnd_chat_app/utils/approuter_paths.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterNotifier extends ChangeNotifier {
  final _firebase = FirebaseAuth.instance;
  RouterNotifier() {
    _firebase.authStateChanges().listen((event) {
      notifyListeners();
    });
  }

  String? redirect(BuildContext context, GoRouterState state) {
    final onLoginPage = state.fullPath == '/auth';

    if (_firebase.currentUser == null) {
      return AppRouterPaths.auth;
    }

    if (_firebase.currentUser != null && onLoginPage) {
      return AppRouterPaths.home;
    }
    return null;
  }
}
