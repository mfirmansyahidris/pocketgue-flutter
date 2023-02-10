import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocketgue/ui/ui.dart';

ThemeData themeDefault = ThemeData(
  fontFamily: 'Ubuntu',
  primaryColor: Palette.primary,
  backgroundColor: Palette.background,
  colorScheme: ThemeData().colorScheme.copyWith(
    primary: Palette.primary,
    secondary: Palette.primary,
    background: Palette.background,
    onSecondary: Palette.primary,
    onPrimary: Palette.primary,
  ),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: Palette.accent),
  textTheme: const TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: Palette.text,
    displayColor: Palette.text,
  ),
  scaffoldBackgroundColor: Palette.white,
  iconTheme: const IconThemeData(color: Colors.black),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Palette.white,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 10,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(color: Palette.white),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

// TextStyles class
class TextStyles {
  TextStyles._();

  static TextStyle h1 = TextStyle(
    fontSize: Dimens.h1,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
    letterSpacing: -1.5,
    color: Palette.text,
  );

  static TextStyle h2 = TextStyle(
    fontSize: Dimens.h2,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
    letterSpacing: 0.5,
    color: Palette.text,
  );

  static TextStyle h3 = TextStyle(
    fontSize: Dimens.h3,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
    letterSpacing: 0,
    color: Palette.text,
  );

  static TextStyle h4 = TextStyle(
    fontSize: Dimens.h4,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
    letterSpacing: 0.25,
    color: Palette.text,
  );

  static TextStyle h5 = TextStyle(
    fontSize: Dimens.h5,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
    letterSpacing: 0,
    color: Palette.text,
  );

  static TextStyle h6 = TextStyle(
    fontSize: Dimens.h6,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
    letterSpacing: 0.15,
    color: Palette.text,
  );

  static TextStyle body1 = TextStyle(
    fontSize: Dimens.body1,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
    letterSpacing: 0.5,
    color: Palette.text,
  );

  static TextStyle body2 = TextStyle(
    fontSize: Dimens.body2,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
    letterSpacing: 0.25,
    color: Palette.text,
  );
}

//
class BoxDecorations {
  BoxDecorations._();

  static BoxDecoration button = BoxDecoration(
    color: Palette.primary,
    borderRadius: BorderRadius.all(Radius.circular(Dimens.cornerRadius)),
    boxShadow: const [BoxShadows.button],
  );

  static BoxDecoration card = BoxDecoration(
    color: Palette.white,
    borderRadius: BorderRadius.all(Radius.circular(Dimens.cornerRadius)),
    boxShadow: [BoxShadows.card],
  );

  static BoxDecoration dialogAlt = BoxDecoration(
    color: Palette.white,
    borderRadius: BorderRadius.all(Radius.circular(Dimens.cornerRadius)),
    boxShadow: const [BoxShadows.dialogAlt],
  );

  static BoxDecoration bottomSheet = BoxDecoration(
    color: Palette.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(Dimens.cornerRadiusXL),
      topRight: Radius.circular(Dimens.cornerRadiusXL),
    ),
    boxShadow: const [BoxShadows.dialog],
  );

  static BoxDecoration buttonMenu = BoxDecoration(
    color: Palette.white,
    borderRadius: BorderRadius.all(
      Radius.circular(Dimens.cornerRadius),
    ),
    boxShadow: const [BoxShadows.buttonMenu],
  );
}

class BoxShadows {
  BoxShadows._();

  static const BoxShadow button = BoxShadow(
    color: Palette.black20,
    blurRadius: 16.0,
    spreadRadius: 1.0,
  );

  static BoxShadow card = BoxShadow(
    color: Palette.black10.withOpacity(0.1),
    blurRadius: 10.0,
    offset: const Offset(0, 1),
  );

  static const BoxShadow dialog = BoxShadow(
    color: Palette.black10,
    offset: Offset(0, -4),
    blurRadius: 16.0,
  );

  static const BoxShadow dialogAlt = BoxShadow(
    color: Palette.black25,
    offset: Offset(0, 4),
    blurRadius: 16.0,
  );

  static const BoxShadow buttonMenu = BoxShadow(
    color: Palette.black25,
    blurRadius: 4.0,
  );
}
