import 'package:flutter/material.dart';

Widget txtHeader(context,txt1,txt2)=> Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(txt1,style: Theme.of(context).textTheme.bodyLarge,),
    Text(txt2,style: Theme.of(context).textTheme.bodyMedium,),
  ],
);