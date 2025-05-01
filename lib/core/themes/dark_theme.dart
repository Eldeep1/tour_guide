import 'package:flutter/material.dart';
const Color mainColor=Colors.amber;
const Color widgetsInMainColor=Colors.white;
const Color iconColor=Colors.white;

const Color appBarColor=Color(0xff0A0F2C);

const buttonColor=Color(0xff1e2f73);

//we are having three colors
//1- the main color, which is the app bar and buttons color ->amber
//3- the text inside the buttons ->black
//4- the text that isn't in a buttons -> white
const Color textColor=Colors.white;

const double circleRadius=8;
const double rectangleRadius=9;
const double screenPadding=16;
const double elevatedButtonHeight=40;
final ThemeData darkTheme=ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: mainColor, // Change this to your desired color
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: mainColor,
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
          backgroundColor: WidgetStatePropertyAll(buttonColor),
        )
    ),

    inputDecorationTheme: InputDecorationTheme(
        fillColor: mainColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circleRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circleRadius),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        labelStyle: TextStyle(
            color: textColor,
            fontSize: 16
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circleRadius),
          borderSide: BorderSide(color: Colors.white, width: 2),
        )
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
        color: appBarColor,
        actionsIconTheme: IconThemeData(
          size: 30,
          color: widgetsInMainColor,
        )
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: textColor,

      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: textColor,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: textColor,
      ),
      bodyMedium: TextStyle(
          color: textColor,
          fontSize: 14,
        fontWeight: FontWeight.bold
      ),
      bodyLarge: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.bold
      ),
    ),
    iconTheme: IconThemeData(
      color: widgetsInMainColor,
      size: 25,
    )
);