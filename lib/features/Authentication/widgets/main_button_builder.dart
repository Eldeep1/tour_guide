import 'package:flutter/material.dart';
import 'package:tour_guide/core/themes/dark_theme.dart';

Widget mainButtonBuilder(txt,context,Function()? onPressFunction)=> Row(
  children: [
    Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 30),
        child: ElevatedButton(
          onPressed: onPressFunction, child: Text(txt,style: Theme.of(context).textTheme.titleLarge),),
      ),
    ),
  ],
);