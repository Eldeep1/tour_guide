import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tour_guide/pages/chat_page/view_model/new_messages_provider.dart';
import 'package:tour_guide/services/components/themes/light_theme.dart';

BoxDecoration messageDecoration({
  required color,
}) =>
    BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12), // Add border radius once
    );

const messagePadding = EdgeInsets.all(16.0);

Color answerMessageColor = mainColor.withAlpha(51);
Color promptMessageColor = mainColor;
Color shimmerBaseColor = Colors.grey;

Widget answerMessageBuilder({String? message, bool isLoading = false}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Extract common container decoration
      final messageStyle = Theme.of(context).textTheme.bodyMedium;

      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: AlignmentDirectional.topStart,
              width: (constraints.maxWidth / 2) + 30,
              child: isLoading
                  ? Stack(
                      children: [
                        Container(
                          decoration:
                              messageDecoration(color: answerMessageColor),
                          child: Padding(
                            padding: messagePadding,
                            child: Text(
                              "loading response",
                              style: messageStyle,
                            ),
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: shimmerBaseColor,
                          highlightColor: answerMessageColor,
                          child: Padding(
                            padding: messagePadding,
                            child: Text(
                              "loading response",
                              style: messageStyle,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      decoration: messageDecoration(color: answerMessageColor),
                      child: Padding(
                        padding: messagePadding,
                        child: Text(
                          message ?? "",
                          style: messageStyle,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      );
    },
  );
}

Widget promptMessageBuilder(
  String? imageLink,
  String message, {
  bool isHistory = true,
  bool isLoading = false,
}) {
  return LayoutBuilder(
    builder: (context, constraints) => Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: AlignmentDirectional.topEnd,
            width: (constraints.maxWidth / 2) + 30,
            child: Consumer(
              builder: (context, ref, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //1- upload the image to the server
                    //2- show the full image on the chat
                    //the below code handles just the case when chat history is true
                    if (imageLink != null && !isLoading)
                      Image.network(imageLink,
                          loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          if (isHistory) {
                            ref
                                .read(newMessagesProvider.notifier)
                                .scrollToBottom();
                          }
                          return child;
                        }
                        return Shimmer.fromColors(
                          baseColor: shimmerBaseColor,
                          highlightColor: promptMessageColor,
                          child: Container(
                            width: double.infinity,
                            height: 200.0,
                            color: shimmerBaseColor,
                          ),
                        );
                      }),
                    if (imageLink != null && isLoading)
                      //show the image somehow, and also show the shimmer
                      Stack(
                        children: [
                          Image.network(
                            imageLink,
                            height: 200.0,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Shimmer.fromColors(
                            baseColor: shimmerBaseColor.withAlpha(51),
                            highlightColor: promptMessageColor,
                            child: Container(
                              width: double.infinity,
                              height: 200.0,
                              color: shimmerBaseColor,
                            ),
                          ),
                        ],
                      ),
                    if (message.isNotEmpty && isLoading)
                      Stack(
                        children: [
                          Container(
                            decoration:
                                messageDecoration(color: promptMessageColor),
                            child: Padding(
                              padding: messagePadding,
                              child: Text(
                                message,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                          Shimmer.fromColors(
                              baseColor: Colors.amber.withAlpha(150),
                              highlightColor: Colors.amberAccent.withAlpha(150),
                              child: Padding(
                                padding: messagePadding,
                                child: Text(
                                  message,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              )),
                        ],
                      ),
                    if (message.isNotEmpty && !isLoading)
                      Container(
                        decoration:
                            messageDecoration(color: promptMessageColor),
                        child: Padding(
                          padding: messagePadding,
                          child: Text(
                            message,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}
