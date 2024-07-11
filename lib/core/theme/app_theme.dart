import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qcracks_mobile/core/theme/colors.dart';



/// SchemeColors
const colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: secondColor,
  onPrimary: secondColor,
  secondary: secondColor,
  onSecondary: secondColor,
  error: secondColor,
  onError: secondColor,
  surface: whiteColor,
  onSurface: outlineGrayColor,
);

const bottomNavigationBarTheme = BottomNavigationBarThemeData(
  backgroundColor: Colors.white,
  elevation: 0,
);


const cupertinoOverrideTheme = CupertinoThemeData(
  primaryColor: secondColor,
  textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(letterSpacing: 0),
  ),
);

const appBarTheme = AppBarTheme(
  backgroundColor: whiteColor,
  elevation: 0,
  centerTitle: true,
);



final appTheme = ThemeData(
  //canvasColor: Colors.transparent,
  primaryColor: secondColor,
  scaffoldBackgroundColor: whiteColor,
  textTheme: GoogleFonts.latoTextTheme(),
  cupertinoOverrideTheme: cupertinoOverrideTheme,
  bottomNavigationBarTheme: bottomNavigationBarTheme,
  appBarTheme: appBarTheme,
  useMaterial3: false,
  colorScheme: colorScheme.copyWith(error: secondColor),
);