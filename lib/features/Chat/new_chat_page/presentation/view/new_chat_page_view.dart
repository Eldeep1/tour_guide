import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/view/widgets/new_chat_page_body_builder.dart';
import 'package:tour_guide/features/Chat/chat_side_bar/presentation/view/chat_side_bar.dart';
import 'package:tour_guide/features/Chat/shared/widgets/app_bar_builder.dart';
import 'package:tour_guide/features/object_detection_page/presentation/view/object_detection_page_beta.dart';

class NewChatPageView extends StatelessWidget {
   const NewChatPageView({super.key,required this.header});

  final String header;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBarBuilder(context),
      // drawer: ChatPageSideBar(),
        appBar: AppBar(

          leading:             IconButton(
            tooltip: "new chat",
            onPressed: () async {

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ProviderScope(child: NewChatPageView(header: "Ask About Anything ")),),
                    (Route<dynamic> route) => false, // This removes all previous routes
              );
            },
            icon: Icon(
              size: 40,
              Icons.edit_note,
            ),
          ),
          actions: [
            IconButton(
              tooltip: "Start Detection",
              onPressed: () async {

                Navigator.push(context, MaterialPageRoute(builder: (context) => ProviderScope(child: ObjectDetectionPage()),));
              },
              icon: Icon(
                Icons.camera_alt_outlined,
              ),
            ),      

          ],
          title: Align(
            alignment: AlignmentDirectional.center,
            child: Text(
              "AI TOUR GUIDE",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      body: Padding(
        padding:const EdgeInsets.only(bottom: 30.0, left: 30, right: 30),
        child: newChatPageBodyBuilder(context,header),
      ),
    );
  }
}
