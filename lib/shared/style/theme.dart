import 'package:flutter/material.dart';
import 'package:lamassu/shared/style/sizes.dart';

import '../../../gen/fonts.gen.dart';
import 'colors.dart';
ThemeData getThemeDataLight(context) => ThemeData(
  fontFamily: FontFamily.notoKufiArabic,
  primaryColor: ColorName.brandPrimary,
  secondaryHeaderColor: ColorName.secondaryLight,
  appBarTheme: getAppBarTheme(),
  scaffoldBackgroundColor: ColorName.secondaryLight,
  elevatedButtonTheme: getElevatedButtonThemeData(context),
  textTheme: getTextTheme(),
  textButtonTheme: getTextButtonThemeData(context),
  floatingActionButtonTheme: getFloatingActionButtonThemeData(),
  colorScheme: getColorScheme(),
);

ColorScheme getColorScheme() {
  return const ColorScheme(
      brightness: Brightness.light,
      primary: ColorName.brandPrimary,
      onPrimary: ColorName.brandPrimary,
      secondary: ColorName.secondaryLight,
      onSecondary: ColorName.secondaryLight,
      error: ColorName.errorColor6,
      onError: ColorName.errorColor5,
      background: ColorName.secondaryLight,
      onBackground: ColorName.NuturalColor1,
      surface: ColorName.NuturalColor2,
      onSurface: ColorName.secondaryLight);
}

AppBarTheme getAppBarTheme() {
  return const AppBarTheme(
      color: ColorName.secondaryLight,
      
      foregroundColor: ColorName.NuturalColor6);
}

FloatingActionButtonThemeData getFloatingActionButtonThemeData() {
  return const FloatingActionButtonThemeData(
      backgroundColor: ColorName.brandPrimary,
      foregroundColor: ColorName.secondaryLight);
}

TextButtonThemeData getTextButtonThemeData(context) {
  return TextButtonThemeData(

    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(
        Size(MediaQuery.of(context).size.width * 1, 48.0),
      ),

      shape:
      MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: Sizes.fontHeader3,

        ),
      ),
    ),
  );
}
//
// TextTheme getTextTheme() {
//   return const TextTheme(
//     // labelLarge for button
//     labelLarge: TextStyle(fontSize: 16.0, color: Colors.black),
//     titleLarge: TextStyle(
//         fontSize: 18.0,
//         fontWeight: FontWeight.w500,
//         color: ColorName.secondaryLight,
//         fontFamily: "Tajawal"),
//     titleMedium: TextStyle(
//         fontSize: 16.0,
//         fontWeight: FontWeight.w700,
//         color: ColorName.secondaryLight,
//         fontFamily: "Tajawal"),
//     titleSmall: TextStyle(
//         fontSize: 14.0,
//         fontWeight: FontWeight.w500,
//         color: ColorName.secondaryLight,
//         fontFamily: "Tajawal"),
//     bodySmall: TextStyle(
//         fontSize: 12.0,
//         fontWeight: FontWeight.w400,
//         color: ColorName.fontSecondaryLight,
//         fontFamily: "Tajawal"),
//     bodyMedium: TextStyle(
//         fontSize: 14.0,
//         fontWeight: FontWeight.w500,
//         color: ColorName.secondaryLight,
//         fontFamily: "Tajawal"),
//     bodyLarge: TextStyle(
//         fontSize: 18.0,
//         fontWeight: FontWeight.w500,
//         color: ColorName.secondaryLight,
//         fontFamily: "Tajawal"),
//   );
// }

TextTheme getTextTheme() => const TextTheme(
  displayLarge: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: ColorName.NuturalColor6,
  ),
  displayMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: ColorName.NuturalColor6),
  displaySmall: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ColorName.NuturalColor6,
  ),
  headlineMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),
  headlineSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: ColorName.NuturalColor6),
  titleLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: ColorName.NuturalColor6),
  bodyLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: ColorName.NuturalColor6),
  bodyMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: ColorName.NuturalColor6),
  bodySmall: TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  ),
  labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: ColorName.NuturalColor6),
);

ElevatedButtonThemeData getElevatedButtonThemeData(context) {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(ColorName.bottomColor),
      fixedSize: MaterialStateProperty.all<Size>(
        Size(MediaQuery.of(context).size.width * 1,
            48.0), // Adjust width as needed
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(8.0), // Set the desired border radius
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
            fontSize: Sizes.fontHeader3,
            color: ColorName.secondaryLight), // Customize text style
      ),
    ),
  );
}