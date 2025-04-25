
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/chat_messages_provider.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/page_variables_provider.dart';
import 'package:tour_guide/features/object_detection_page/presentation/view/object_detection_page.dart';

class SendMessageFormFieldBuilder extends StatelessWidget {
   const SendMessageFormFieldBuilder({super.key});

   @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final newMessage=ref.read(chatDataProvider.notifier);
        final controller=ref.read(sendMessageFormController);
        return SizedBox(
          height: 100,
          child: TextFormField(
            controller: controller,
            style: Theme.of(context).textTheme.bodyMedium,
            minLines: null,
            maxLines: null,
            expands: true,
            // textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText: "Ask anything",
              // contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      padding: EdgeInsetsDirectional.zero,
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ObjectDetectionPage();
                        },));
                      },
                      icon: CircleAvatar(
                        backgroundColor: mainColor,
                        radius: 16,
                        child: Icon(Icons.smart_toy_outlined,),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsetsDirectional.zero,
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        newMessage.sendMessage(prompt: controller.text);
                      },
                      icon: CircleAvatar(
                        backgroundColor: mainColor,
                        radius: 16,
                        child: Icon(Icons.arrow_upward_sharp,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}



