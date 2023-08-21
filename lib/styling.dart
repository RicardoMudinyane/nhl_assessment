import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


/// This class contains Colors and TextStyles
class AppStyling{
  TextStyle largeText = GoogleFonts.poppins(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  TextStyle smallText = GoogleFonts.poppins(
      fontSize: 11,
    color: Colors.grey[600],
    fontWeight: FontWeight.w400,
  );
  TextStyle hintText = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    color: Colors.grey,
    fontSize: 12,
  );

  Color nhlColor = const Color(0xff111111);
  Color nhlTextColor = const Color(0xffe4e5e7);
  Color backgroundColor = Colors.grey[200]!;
}