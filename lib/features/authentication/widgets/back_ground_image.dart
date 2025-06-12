import 'package:flutter/material.dart';
import 'package:tour_guide/core/utils/Assets/assets.dart';

Widget backgroundImage(double opacity){
  return Container(
    height: double.maxFinite,
    width: double.maxFinite,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15,),
        image: DecorationImage(image: AssetImage(Assets.background),opacity: opacity,fit: BoxFit.fill)
    ),

  );

}