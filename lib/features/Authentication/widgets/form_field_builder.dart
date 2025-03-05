import 'package:flutter/material.dart';

Widget formFieldBuilder(String text,{double? width})=>SizedBox(
  width: width,
  child: Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: TextFormField(
      decoration: InputDecoration(
        label: Text(text),
      ),
    ),
  ),
);
