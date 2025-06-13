import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/themes/theme_provider.dart';
import 'package:tour_guide/features/splash_screen/presentation/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeNotifier = ThemeNotifier();
  await themeNotifier.loadInitialTheme();

  runApp(ProviderScope(
    overrides: [
      themeProvider.overrideWith((ref) => themeNotifier),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final themeNotifier =
            ref.watch(themeProvider);
        return MaterialApp(
          title: 'AI Tour Guide',
          theme: themeNotifier.themeData,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
