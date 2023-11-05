import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App_AppBar extends AppBar {
  final List<Widget>? actions;

  App_AppBar({Key? key, this.actions})
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
