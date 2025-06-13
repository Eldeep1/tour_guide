import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/providers/chat_messages_provider.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/providers/page_variables_provider.dart';
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
                width: 80,
                height: 80,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        fit: BoxFit.fill,
                        image,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
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
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => ObjectDetectionPage(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              var begin = Offset(1.0, 0.0); // Slide in from the right
                              var end = Offset.zero;
                              var curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },

                      icon: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 30,
                        child: Icon(
                          Icons.camera_alt_outlined,
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
