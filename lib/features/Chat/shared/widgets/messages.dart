import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';

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

Widget answerMessageBuilder({required String message, bool isLoading = false}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Extract common container decoration

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
                        // responseMessageContainer(context,"Loading Response"),

                        Shimmer.fromColors(
                          baseColor: shimmerBaseColor,
                          highlightColor: answerMessageColor,
                          child: responseMessageContainer(context,message),

                        ),
                      ],
                    )
                  : responseMessageContainer(context,message),
            ),
          ),
        ],
      );
    },
  );
}
Widget responseMessageContainer(context,String message,{bool error=false}){
  final messageStyle = Theme.of(context).textTheme.bodyMedium;

  return Container(
    decoration: messageDecoration(color:error?Colors.red: answerMessageColor),
    child: Padding(
      padding: messagePadding,
      child: MarkdownBody(
        data: message,
        styleSheet: MarkdownStyleSheet(
          h3: messageStyle!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
Widget promptMessageBuilder(
  String message, {
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
                      Stack(
                        children: [
                          promptMessageContainer(context,message),
                          if (isLoading)
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
Widget promptMessageContainer(context, String message){
  return Container(
    decoration:
    messageDecoration(color: promptMessageColor),
    child: Padding(
      padding: messagePadding,
      child: Text(
        message,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    ),
  );
}

Widget errorMessageBuilder(String message) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Extract common container decoration

      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: AlignmentDirectional.topStart,
              width: (constraints.maxWidth / 2) + 30,

                   child: responseMessageContainer(context,message,error: true),
            ),
          ),
        ],
      );
    },
  );
}