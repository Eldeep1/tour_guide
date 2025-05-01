import 'package:flutter/material.dart';

const largeScreenSize=700;

const abdelNasserBackground="assets/images/lol.png";

const String newChatMessage="What Can I Help With";

const String apiLink="http://4.156.161.197/";

const String sendingMessageEndPoint="nlp/response";
Widget backgroundGradient ({Widget? child})=>Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xff000412),  Color(0xff070E26),Colors.deepPurple,],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  child: child,
);
Widget reversedBackgroundGradient({Widget? child})=>Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xff000412),  Color(0xff070E26),],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
child: child,
);