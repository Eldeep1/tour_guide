
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/features/Chat/shared/providers/new_messages_provider.dart';
import 'package:tour_guide/features/Chat/shared/providers/tmp_shit.dart';


class SendMessageFormFieldBuilder extends StatelessWidget {
   SendMessageFormFieldBuilder({super.key,this.talkingAbout});


  String? talkingAbout;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final newMessage=ref.read(tmpNewMessagesProvider.notifier);
        return SizedBox(
          height: 100,
          child: TextFormField(
            controller: newMessage.chatFormController,
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
                      onPressed: () {
                        newMessage.sendMessage(talkingAbout);
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
