import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
// in AppBar only.
    iconTheme: IconThemeData(color: Colors.black),
  ),
// In all app without AppBar.
  iconTheme: const IconThemeData(color: Colors.black),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
    elevation: 25.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
    bodyText2: TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
    headline6: TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
  ),
  fontFamily: 'CairoSemiBold',
);
ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: defaultColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
    ),
    // in AppBar only.
    iconTheme: IconThemeData(color: Colors.white),
  ),
  // In all app without AppBar.
  iconTheme: const IconThemeData(color: Colors.white),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
    elevation: 25.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    ),
    bodyText2: TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    ),
    headline6: TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    ),
  ),
  fontFamily: 'CairoBold',
);
