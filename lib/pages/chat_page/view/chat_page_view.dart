import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tour_guide/pages/chat_page/view/components/camer_preview.dart';

import 'package:tour_guide/pages/chat_page/view/components/chat_text_form-field.dart';
import 'package:tour_guide/pages/chat_page/view/components/side_bar.dart';
import 'package:tour_guide/pages/chat_page/view_model/imgae_provider.dart';
import 'package:tour_guide/services/components/themes/light_theme.dart';

import '../view_model/new_messages_provider.dart';
import '../view_model/side_bar_provider.dart';
import 'components/chat_messages_history.dart';


class ChatPageView extends StatelessWidget {
  final int? chatID; // Make it final

    const ChatPageView({super.key,required this.chatID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:ChatPageSideBar(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            tooltip: "show Side bar",
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Align(
              alignment: AlignmentDirectional.center,
              child: SvgPicture.asset(
                colorFilter: ColorFilter.mode(widgetsInMainColor, BlendMode.srcIn),
                "assets/icons/mobile/sidebar_open.svg",
                alignment: AlignmentDirectional.center,
              ),
            ),
          );
        }),
        actions: [
          IconButton(
            tooltip: "new chat",
            onPressed: () async {

              Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPreviewScreen(),));
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
        padding: const EdgeInsets.only(bottom: 30.0, left: 30, right: 30),
        child: Column(
          children: [
            Expanded(

                child: Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    ref.read(sideBarProvider('sidebar')); // Fetch data first

                    if(chatID==null){
                      ref.read(showWelcomeProvider.notifier).state = true;

                    }
                    final messageProvider = ref.read(newMessagesProvider.notifier); // Read for calling methods
                    return SingleChildScrollView(
                      controller: messageProvider.pageScrollController,
                      child: Column(
                        children: [
                          chatID==null?
                          welcomeBuilder(context)
                          :ProviderScope(child: ChatHistory(chatID: chatID!,)),
                          Consumer(
                            builder: (context, ref, child) {
                              final messagesState = ref.watch(newMessagesProvider); // Watch state directly
                              return Column(
                                children: messagesState,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),

            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                viewingImageBuilder(),
                ChatTextFormField(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget welcomeBuilder(context){

return Consumer(builder: (context, ref, child) {
  final showWelcomeBuilder=ref.watch(showWelcomeProvider);

  if(showWelcomeBuilder) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: Center(
        child: Text("What Can I Help With",),
      ),
    );
  }
  return Container();
},);

  }
  Widget viewingImageBuilder(){
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final imageElement=ref.watch(isImageExists);
        final imagePath=ref.watch(newMessagesProvider.notifier);
        if(imageElement) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                SizedBox(
                  height: 80,
                  child: imagePath.image != null
                      ? (kIsWeb
                      ? Padding(
                    padding: const EdgeInsets.only(right: 8.0,top: 8.0),
                    child: Image.network(imagePath.image!.path, fit: BoxFit.cover),
                  )
                      : Image.file(File(imagePath.image!.path), fit: BoxFit.cover))
                      : Container(),),
                IconButton(
                  splashRadius: 15,
                  padding: EdgeInsetsDirectional.zero,
                  onPressed: () {
                    ref.read(isImageExists.notifier).state=false;

                  },
                  icon: CircleAvatar(
                    backgroundColor: mainColor,
                    radius: 15,
                    child: Icon(

                      Icons.close,

                      size: 15,
                    ),
                  ),
                )
              ],
            ),
          );
        } else{
          return Container();
        }
      },
    );
  }
}
