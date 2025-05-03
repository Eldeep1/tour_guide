import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/themes/dark_theme.dart';
import 'package:tour_guide/core/themes/theme_provider.dart';
import 'package:tour_guide/features/Authentication/login/presentation/view/login_page_view.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/view/new_chat_page_view.dart';
import 'package:tour_guide/features/splash_screen/presentation/view/splash_screen.dart';

void main() {
  runApp(ProviderScope(child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final themeNotifier = ref.watch(themeProvider); // 👈 watch the whole notifier

        return MaterialApp(
          title: 'AI Tour Guide',
          theme: themeNotifier.themeData, // 👈 this will now update properly
          debugShowCheckedModeBanner: false,
          home: LoginPageView(),
        );
      },
    );
  }
}
