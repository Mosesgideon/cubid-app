import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media/app_constants/theme/app_colors.dart';

class AppTheme {
  AppTheme._();
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: lightBackgroundColor,
    fontFamily: 'Poppins',
    cardColor: lightCardColor,
    primaryColor: primaryColorBlack,
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor:lightBottomSheetColor),
    appBarTheme: AppBarTheme(
      color: lightBackgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      toolbarTextStyle: const TextStyle(
        color: black,
      ),
      titleSpacing: 0,
      iconTheme: const IconThemeData(
        color: Colors.blueGrey,
      ),
    ),
    colorScheme:  const ColorScheme.light(
        primary: carddarkcolor,
        onPrimary:textcolor,
        primaryContainer: Colors.white38,
        secondary: secondaryGoldColor,
        surface: inputColorLight,
        onBackground:black,
        onSecondary: btncolor),
    cardTheme: const CardTheme(
      color: lightCardColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightCardColor,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black),
    iconTheme: const IconThemeData(
      color: darkGrey,
    ),
  );

  // static final lightTheme = ThemeData.light().copyWith(
  //     scaffoldBackgroundColor: Colors.white,
  //     cardColor: Colors.grey,
  //     colorScheme: const ColorScheme.light(onBackground: Colors.black));

  static final darkTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: darkBackgroundColor,
      cardColor: darkBackgroundColor,
      // const Color(0xFF282a37),
      primaryColor: primaryColorDark,
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor:darkBottomSheetColor),
      appBarTheme: AppBarTheme(
        backgroundColor: darkBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
        iconTheme: const IconThemeData(
          color:darkGrey,
        ),
      ),
      colorScheme:  const ColorScheme.light(
          primary: btncolor,
          onPrimary: textcolor,
          primaryContainer: Color(0xFF141d26),
          secondary:secondaryGoldColor,
          onSecondary: Colors.white,
          surface: inputColorDark,
          onBackground:  Colors.white),
      cardTheme: const CardTheme(
        color: darkCardColor,
      ));

}
