// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tour_guide/features/Chat/new_chat_page/presentation/view/new_chat_page_view.dart';
//
// Widget detectionButtonsRawBuilder(modelNotifier,context)=>Positioned(
//   bottom: 130,
//   width: MediaQuery.of(context).size.width,
//   child: Column(
//     children: [
//       Container(
//         height: 80,
//         width: 80,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(width: 5, color: Colors.white),
//         ),
//
//         child:
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             !modelNotifier.isDetecting?
//             IconButton(
//               onPressed: () async {
//                 await modelNotifier.startDetection();
//                 modelNotifier.firstTime=false;
//               },
//               icon: const Icon(Icons.play_arrow,
//                   color: Colors.white),
//               iconSize: 50,
//             ):
//             IconButton(
//               onPressed: () async {
//                 await modelNotifier.stopDetection();
//               },
//               icon: const Icon(Icons.stop, color: Colors.red),
//               iconSize: 50,
//             ),
//
//           ],
//         ),
//       ),
//       Column(
//         children: [
//           if(modelNotifier.kingName.compareTo("firstTime")==0)
//             Text("Click To Start Detection"),
//
//           if(!modelNotifier.isDetecting&&modelNotifier.kingName.isEmpty)
//           Text("No Monuments Detected"),
//           if(!modelNotifier.isDetecting&&modelNotifier.kingName.isNotEmpty&&modelNotifier.kingName.compareTo("firstTime")!=0)
//           ElevatedButton(onPressed: (){
//             Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => NewChatPageView(header: "Chatting About ${modelNotifier.kingName}")),
//               (Route<dynamic> route) => false, // This removes all previous routes
//             );
//           }, child: Text("Chat About ${modelNotifier.kingName}")),
//         ],
//       )
//
//     ],
//   ),
// );