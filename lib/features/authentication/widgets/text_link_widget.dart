import 'package:flutter/material.dart';
import 'package:tour_guide/core/themes/dark/dark_theme.dart';

Widget textLinkWidget(String txt1, String txt2,Function()? onPressFunction, context){
  return Row(
    children: [
      Text("$txt1 ",style: Theme.of(context).textTheme.bodyMedium,),
      TextButton(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsetsDirectional.zero),
        ),
        onPressed:
        onPressFunction
        , child: Text(txt2,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainColorDark),),
      ),
    ],
  );
}
