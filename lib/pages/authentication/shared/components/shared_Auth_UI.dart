import 'package:flutter/material.dart';
import 'package:tour_guide/services/components/constants/constants.dart';
import 'package:tour_guide/services/components/themes/light_theme.dart';

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

Widget backgroundImage(double opacity){
  return Container(
    height: double.maxFinite,
    width: double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15,),
      image: DecorationImage(image: AssetImage(abdelNasserBackground),opacity: opacity,fit: BoxFit.fill)
    ),

  );

}

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
        , child: Text("$txt2",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainColor),),
      ),
    ],
  );
}

Widget txtHeader(context,txt1,txt2)=> Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(txt1,style: Theme.of(context).textTheme.bodyLarge,),
    Text(txt2,style: Theme.of(context).textTheme.bodyMedium,),
  ],
);

Widget signButtonBuilder(txt,context,Function()? onPressFunction)=> Padding(
  padding: const EdgeInsets.symmetric(vertical: 15.0),
  child: ElevatedButton(
    onPressed: onPressFunction, child: Text(txt,style: Theme.of(context).textTheme.titleLarge),),
);
