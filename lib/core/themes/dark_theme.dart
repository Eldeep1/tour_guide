import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/themes/theme_provider.dart';

import 'light_theme.dart';
const Color mainColorDark=Colors.amber;
const Color widgetsInMainColorDark=Colors.white;
// const Color iconColor=Colors.white;

const Color appBarColorDark=Color(0xff0A0F2C);

const buttonColorDark=Color(0xff1e2f73);

const Color textColor=Colors.white;

const Color messageTextColor=Colors.white;
Widget backgroundGradient ({Widget? childWidget})=>Consumer(
  builder: (BuildContext context, WidgetRef ref, Widget? child) {
    final themeMode=ref.watch(themeProvider.notifier).themeData;
    if( themeMode==lightTheme){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
          color: Color(0xFFECF1FF),

        ),
        child: childWidget,
      );
    }
    return Container(
      decoration: BoxDecoration(

        gradient: LinearGradient(
          colors: [Color(0xff000412),  Color(0xff070E26),Colors.deepPurple,],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: childWidget,
    );
  },
);


Widget reversedBackgroundGradient({Widget? childWidget})=>Consumer(
  builder: (BuildContext context, WidgetRef ref, Widget? child) {
    if(ref.watch(themeProvider.notifier).themeData ==lightTheme){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
          color: Color(0xFFECF1FF),

        ),
        child: childWidget,
      );
    }
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff000412),  Color(0xff070E26),],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: childWidget,
    );
  },
);


const double circleRadius=8;
const double rectangleRadius=9;
const double screenPadding=16;
const double elevatedButtonHeight=40;
final ThemeData darkTheme=ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: mainColorDark, // Change this to your desired color
    ),

    primaryColor: buttonColorDark,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: mainColorDark,
    ),
    // drawerTheme: DrawerThemeData(
    //   backgroundColor: widgetsInMainColorDark,
    //
    // ),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          fixedSize:WidgetStatePropertyAll(Size.fromHeight(elevatedButtonHeight)) ,
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(rectangleRadius))
          ),
          ),
          backgroundColor: WidgetStatePropertyAll(buttonColorDark),
        )
    ),

    inputDecorationTheme: InputDecorationTheme(
        fillColor: mainColorDark,
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
        color: appBarColorDark,
        actionsIconTheme: IconThemeData(
          size: 30,
          color: widgetsInMainColorDark,
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
        color: messageTextColor,
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
      color: widgetsInMainColorDark,
      size: 25,
    )
);