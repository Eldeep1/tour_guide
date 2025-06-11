import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/chat_messages_provider.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/page_variables_provider.dart';
import 'package:tour_guide/features/object_detection_page/presentation/view/object_detection_page.dart';

class SendMessageFormFieldBuilder extends ConsumerStatefulWidget {
  const SendMessageFormFieldBuilder({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: clean that page
    return _SendMessageFormFieldBuilderState();
  }
}

class _SendMessageFormFieldBuilderState extends ConsumerState<SendMessageFormFieldBuilder> {
  TextEditingController sendMessageTextEditingController=TextEditingController();

  int? previousChatID;
  @override
  void dispose() {
    sendMessageTextEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final newMessage = ref.read(chatDataProvider.notifier);
    final currentRequest = ref.watch(messageRequestProvider);

    final messageRequest=ref.read(messageRequestProvider.notifier).state;
    print(messageRequest.image);
    print(messageRequest.label);
    print(messageRequest.chatID);
    print(messageRequest.prompt);
    if(previousChatID!=currentRequest.chatID){
      previousChatID=currentRequest.chatID;
      sendMessageTextEditingController.clear();
      messageRequest.image=null;
      messageRequest.label=null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final image= ref.read(messageRequestProvider.notifier).state.image?.bytes;

            if(image!=null) {
              return SizedBox(
                width: 150,
                height: 150,
                child: Stack(
                  children: [
                    Image.memory(
                      image,
                      width: 150,
                      height: 150,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0,right: 2),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 20,
                              color: Colors.white,
                            ),
                            onPressed: (){
                              setState(() {

                              });
                              messageRequest.image=null;
                              messageRequest.label=null;
                            },
                          ),
                        ),
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
                  controller: sendMessageTextEditingController,
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
                        if(ref.read(sendingMessage)==false&&(sendMessageTextEditingController.text.isNotEmpty || messageRequest.image!=null)){
                          newMessage.sendMessage(prompt: sendMessageTextEditingController.text);
                          sendMessageTextEditingController.text="";
                        }
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
  }
}
