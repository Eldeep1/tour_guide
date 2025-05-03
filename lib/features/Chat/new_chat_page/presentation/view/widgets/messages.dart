import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tour_guide/core/themes/dark_theme.dart';
import 'package:tour_guide/core/themes/theme_provider.dart';
import 'package:tour_guide/core/utils/Assets/assets.dart';



BoxDecoration responseMessageDecoration(WidgetRef ref) {
  final theme = ref.watch(themeProvider.notifier).themeData;

  bool isDark=theme==darkTheme;

  return BoxDecoration(
    color: isDark ? const Color(0xff10183a) : Colors.white,
    borderRadius: BorderRadius.circular(12),
  );
}


BoxDecoration errorMessageDecoration= BoxDecoration(
  color: Colors.red,
  borderRadius: BorderRadius.circular(12), // Add border radius once
);
BoxDecoration requestMessageDecoration=
    BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xff2c41ff),Color(0xff00a3ff)]),
      borderRadius: BorderRadius.circular(12), // Add border radius once
    );

Widget chatIcon = Image.asset(
  width: 60,
  height: 70,
  Assets.modelIcon,
  fit: BoxFit.cover, // or BoxFit.fill depending on how you want it
);

const messagePadding = EdgeInsets.all(16.0);


Widget responseMessageContainer(context,String message,{bool error=false}){


  return Consumer(
    builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final theme = ref.watch(themeProvider.notifier).themeData;
      bool isDark=theme==darkTheme;
      TextStyle? messageStyle;
      if(isDark||error){
        messageStyle= Theme.of(context).textTheme.titleMedium;

      }
      else {
        messageStyle = Theme.of(context).textTheme.titleMedium!.copyWith(color: Color(0xFF5A5B5F));
      }


      return Container(

        decoration:error? errorMessageDecoration:responseMessageDecoration(ref),
        child: Padding(
          padding: messagePadding,
          child: MarkdownBody(
            data: message,
            styleSheet: MarkdownStyleSheet(
              p: messageStyle, // 👈 for normal paragraph text
              h3: messageStyle!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    },
  );
}

Widget answerMessageBuilder({required String message, bool isLoading = false}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Extract common container decoration

      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          chatIcon,
          Container(
            alignment: AlignmentDirectional.topStart,
            width: constraints.maxWidth/1.3 ,
            child: isLoading
                ? Align(
                alignment: AlignmentDirectional.topStart,
                child: LottieBuilder.asset("assets/lotties/loading_message.json"))
                : responseMessageContainer(context,message),
          ),
        ],
      );
    },
  );
}

Widget promptMessageBuilder(
  String message) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    promptMessageContainer(context,message),
                  ],
                ),
              ],
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
    requestMessageDecoration,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          chatIcon,
          Container(
            alignment: AlignmentDirectional.topStart,
            width: (constraints.maxWidth / 2) + 30,

                 child: responseMessageContainer(context,message,error: true),
          ),
        ],
      );
    },
  );
}