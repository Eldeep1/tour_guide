import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/pages/chat_page/view_model/imgae_provider.dart';
import 'package:tour_guide/pages/chat_page/view_model/new_messages_provider.dart';
import 'package:tour_guide/services/components/themes/light_theme.dart';
import 'package:tour_guide/services/image_picker/image_picker_helper.dart';

class ChatTextFormField extends StatelessWidget {
  final imagePickerHelper=ImagePickerHelper();
   ChatTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final newMessage=ref.read(newMessagesProvider.notifier);
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
                      onPressed: () async {
                        imagePickerHelper.openImagePicker(context).then(
                              (value) {
                            if(value!=null)
                            {
                              ref.read(isImageExists.notifier).state=false;
                              ref.read(isImageExists.notifier).state=true;
                              newMessage.image=value;
                            }
                          },
                        );
                      },
                      icon: CircleAvatar(
                        backgroundColor: mainColor,
                        radius: 16,
                        child: Icon(Icons.attach_file,),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(showWelcomeProvider.notifier).state=false;

                        newMessage.sendMessage();
                        ref.read(isImageExists.notifier).state=false;

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
