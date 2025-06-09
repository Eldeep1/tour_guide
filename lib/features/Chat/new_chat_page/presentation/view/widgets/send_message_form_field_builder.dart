import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/themes/light_theme.dart';
import 'package:tour_guide/core/themes/theme_provider.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/chat_messages_provider.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/page_variables_provider.dart';
import 'package:tour_guide/features/object_detection_page/presentation/view/object_detection_page.dart';

class SendMessageFormFieldBuilder extends StatelessWidget {
  const SendMessageFormFieldBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final newMessage = ref.read(chatDataProvider.notifier);
        final controller = ref.read(sendMessageFormController);

        return Column(
          children: [
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  String detectedMonument=ref.read(foundMonument);
                  ref.watch(foundMonument);
                  if(detectedMonument.isNotEmpty) {
                    return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Container(
                          width:MediaQuery.sizeOf(context).width-180,
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: ref.read(themeProvider.notifier).themeData==lightTheme?Colors.grey.shade300:Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Text(
                                  "Asking about ${ref.read(foundMonument)}",
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500,

                                    fontSize: 12
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ref.read(foundMonument.notifier).state="";
                                },
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                  }
                  else{
                    return SizedBox();
                  }
                },
              ),

            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
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
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          padding: EdgeInsetsDirectional.zero,
                          visualDensity: VisualDensity.compact,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ObjectDetectionPage();
                              },
                            ));
                          },
                          icon: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 30,
                            child: Icon(
                              Icons.smart_toy_outlined,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        IconButton(
                          padding: EdgeInsetsDirectional.zero,
                          visualDensity: VisualDensity.compact,
                          onPressed: () {
                            newMessage.sendMessage(prompt: controller.text);
                          },
                          icon: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 30,
                            child: Icon(
                              Icons.send_outlined,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
