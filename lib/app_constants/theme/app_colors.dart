import 'dart:ui';
import 'package:flutter/material.dart';
// const darkBackgroundColor=Color(0xff0A1316);
const darkBackgroundColor=Color(0xff0A1316);
const cardlightcolor=Color(0xff4f5257);
const Color lightBackgroundColor = Color(0xFFFFFAF4);
const Color lightCardColor = Color(0xFFFFFAF4);

const cardColor=  Color(0xff0A1316);
// const cardcolor=Color(0xff7B0F81);
const carddarkcolor=Color(0xff7a4c6b);
const Color darkCardColor = Color(0xFF211E1E);
const lightpurple=Color(0xffEC8CCE);
const txtcolor=Color(0xffD0D0D0);
const btncolor=Color(0xff330D35);
const textcolor=Color(0xffD0D0D0);
const yello=Color(0xffE7AC63);
const primaryColorDark=Color(0xff332d2d);
const Color primaryColorBlack = Color(0xFF070400);
const darkBottomSheetColor=Color(0xff4c4848);
const darkGrey=Color(0xFFA4A4A4);
const Color lightBottomSheetColor = Colors.white;
const Color black = Colors.black;
const smokeWhite = Color(0xFFf1f7f8);
// const Color black = Colors.black;
const red = Color(0xff111e21);//check out b4 anything
const Color gold = Color(0xFFcfa23c);
const Color inputColorDark = Color(0xFF211E1E);
const Color inputColorLight = Color(0xffF8F2EA);
const Color secondaryGoldColor = Color(0xFFE7AC63);
const lightGrey = Color(0xFFebebf7);


extension ColorSchemeEx on ColorScheme {
  Color get backgroundColor =>
      brightness == Brightness.dark
          ? darkBackgroundColor
          : lightBackgroundColor;

  Color get toolbarColor =>
      brightness == Brightness.dark
          ? darkBackgroundColor
          : lightBackgroundColor;

}