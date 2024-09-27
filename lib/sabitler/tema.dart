import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tema {
  inputDec(String hinText, IconData icon) {
    return InputDecoration(
      border: InputBorder.none,
      hintText: hinText,
      hintStyle: GoogleFonts.quicksand(
        color: Colors.black,
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.blue,
      ),
    );
  }

  inputBoxDec() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    );
  }
}
