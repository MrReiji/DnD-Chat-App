import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppAppBar extends AppBar {
  final List<Widget>? actions;

  AppAppBar({Key? key, this.actions})
      : super(
            key: key,
            title: Center(
              child: Text(
                "DnD Chat App",
                style: GoogleFonts.outfit(fontSize: 30),
              ),
            ),
            actions: actions);
}
