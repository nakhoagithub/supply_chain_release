import 'package:flutter/material.dart';

class ThemeApp {
  static Color button = const Color(0xff3a3485);

  static Color backgroundScafold = const Color(0xfff6f6f6);

  static TextStyle textStyle(
      {Color? color, FontWeight? fontWeight, double? fontSize}) {
    return TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize);
  }

  static ThemeData themeData() {
    return ThemeData(
      scaffoldBackgroundColor: backgroundScafold,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          actionsIconTheme: IconThemeData(color: Colors.black87)),
    );
  }
}
