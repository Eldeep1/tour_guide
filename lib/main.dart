import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/features/Authentication/login/presentation/view/login_page_view.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/view/new_chat_page_view.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Tour Guide',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: ProviderScope(child:  NewChatPageView(header: "Ask About Anything")),
    );
  }
}
