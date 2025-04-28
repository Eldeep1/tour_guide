import 'package:flutter/material.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';

Widget mainButtonBuilder(txt,context,Function()? onPressFunction)=> Row(
  children: [
    Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 30),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(buttonColor)
          ),
          onPressed: onPressFunction, child: Text(txt,style: Theme.of(context).textTheme.titleLarge),),
      ),
    ),
  ],
);

//
// Widget mainButtonBuilder(String txt, BuildContext context, Function()? onPressFunction) => Padding(
//   padding: const EdgeInsets.symmetric(vertical: 15.0),
//   child: ElevatedButton(
//     onPressed: onPressFunction,
//     style: ElevatedButton.styleFrom(
//       padding: EdgeInsets.zero, // Removes default padding to fit the gradient
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
//       ),
//     ),
//     child: Ink(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xff000412), Colors.deepPurple],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(10), // Match the button's border radius
//       ),
//       child: Material(
//         elevation: 5, // Add elevation here
//         borderRadius: BorderRadius.circular(10), // Match the gradient's border radius
//         color: Colors.transparent, // Ensure the Material widget doesn't override the gradient
//         child: Container(
//           constraints: BoxConstraints(minWidth: 100, minHeight: 50), // Adjust size as needed
//           alignment: Alignment.center,
//           child: Text(
//             txt,
//             style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
//           ),
//         ),
//       ),
//     ),
//   ),
// );
