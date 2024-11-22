import 'package:flutter/material.dart';


class AppStyles {
  static const Color primaryColor = Color.fromARGB(255, 97, 197, 102);
  static const Color secondaryBlueColor = Color.fromARGB(255, 54, 71, 149);
  static const Color backgroundColor= Color.fromARGB(255, 255, 255, 255);
  

  static const TextStyle tileTitleTextStyle = TextStyle(color: primaryColor, fontSize: 20);
  static final TextStyle tileSubtitleTextStyle = TextStyle(color: secondaryBlueColor.withOpacity(0.8), fontSize: 14);
  static const TextStyle tileTrailingTextStyle = TextStyle(color: secondaryBlueColor, fontSize: 14);
}