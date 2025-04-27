import 'package:flutter/material.dart';
const Color mainColor=Colors.amber;
const Color widgetsInMainColor=Colors.white;
const Color appBarColor=Color(0xff0A0F2C);

const buttonColor=Color(0xff1e2f73);

//we are having three colors
//1- the main color, which is the app bar and buttons color ->amber
//3- the text inside the buttons ->black
//4- the text that isn't in a buttons -> white
const Color freeTextColor=Colors.white;

const double circleRadius=15;
const double rectangleRadius=9;
const double screenPadding=16;
const double elevatedButtonHeight=40;
final ThemeData lightTheme=ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: mainColor, // Change this to your desired color
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: mainColor,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: widgetsInMainColor,

    ),
    textButtonTheme: TextButtonThemeData(

      style: ButtonStyle(

        // backgroundColor: WidgetStatePropertyAll(mainColor),
      ),

    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          fixedSize:WidgetStatePropertyAll(Size.fromHeight(elevatedButtonHeight)) ,
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(rectangleRadius))
          ),
          ),
          backgroundColor: WidgetStatePropertyAll(mainColor),
        )
    ),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: mainColor,
        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(circleRadius),

        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circleRadius),
          borderSide: BorderSide(color: freeTextColor),
        ),
        labelStyle: TextStyle(
            color: freeTextColor,
            fontSize: 16
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circleRadius),
          borderSide: BorderSide(color: mainColor),
        )
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
        color: mainColor,
        actionsIconTheme: IconThemeData(
          size: 30,
          color: widgetsInMainColor,
        )
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: widgetsInMainColor,

      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: widgetsInMainColor,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: freeTextColor,
      ),
      bodyMedium: TextStyle(
          color: freeTextColor,
          fontSize: 16
      ),
      bodyLarge: TextStyle(
          color: freeTextColor,
          fontSize: 18,
          fontWeight: FontWeight.bold
      ),
    ),
    iconTheme: IconThemeData(
      color: widgetsInMainColor,
      size: 25,
    )
);