import 'package:flutter/material.dart';

const Color mainColorLight=Colors.amber;
const double circleRadius=8;
const double rectangleRadius=9;
const double screenPadding=16;
const double elevatedButtonHeight=40;
const Color widgetsInMainColor=Colors.black;
const Color textColorLight=Colors.black;

const Color messageTextColor=Colors.white;
// const Color messageTextColor=Color(0xffC8C9CD);
const Color appBarColorLight=Colors.white;

const Color buttonColorLight=Colors.white;
final ThemeData lightTheme=ThemeData(

  primaryColor:buttonColorLight,
    colorScheme: ColorScheme.fromSeed(
      seedColor: mainColorLight, // Change this to your desired color
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black,
    ),
    // drawerTheme: DrawerThemeData(
    //   backgroundColor: widgetsInMainColor,
    //
    // ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          fixedSize:WidgetStatePropertyAll(Size.fromHeight(elevatedButtonHeight)) ,
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(rectangleRadius))
          ),
          ),
          backgroundColor: WidgetStatePropertyAll(buttonColorLight),
        )
    ),

    inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
      filled: true, // 👈 important to show the fillColor
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circleRadius), // 👈 Rounded corners
        borderSide: BorderSide.none, // 👈 No border line
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circleRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circleRadius),
        borderSide: BorderSide(color: Colors.black),
      ),
        labelStyle: TextStyle(
            color: textColorLight,
            fontSize: 16
        ),

    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        color: appBarColorLight,
        actionsIconTheme: IconThemeData(
          size: 30,
          color: widgetsInMainColor,
        ),
    ),

    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: textColorLight,

      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: messageTextColor,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: textColorLight,
      ),
      bodyMedium: TextStyle(
          color: textColorLight,
          fontSize: 14,
          fontWeight: FontWeight.bold
      ),
      bodyLarge: TextStyle(
          color: textColorLight,
          fontSize: 18,
          fontWeight: FontWeight.bold
      ),
    ),

    iconTheme: IconThemeData(
      color: widgetsInMainColor,
      size: 25,
    )
);
