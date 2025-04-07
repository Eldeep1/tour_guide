import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Chat/shared/providers/new_messages_provider.dart';
import 'package:tour_guide/features/Chat/shared/providers/tmp_shit.dart';
import 'package:tour_guide/features/Chat/shared/widgets/send_message_form_field_builder.dart';

Widget newChatPageBodyBuilder(context,String header){

  return Consumer(
    builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final newMessages = ref.watch(tmpNewMessagesProvider);
      final messageProvider = ref.read(tmpNewMessagesProvider.notifier); // Read for calling methods
messageProvider.chatHeader=header;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if(newMessages.isEmpty)
            Expanded(
              child: Center(
                child: Text(header,),
              ),
            ),
            if(newMessages.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  controller: messageProvider.pageScrollController,
                  child: Column(
                    children: [
                      ...newMessages,
                    ],
                  
                  ),
                ),
              ),
            SendMessageFormFieldBuilder(),

          ],
        ),
      );
    },);
}