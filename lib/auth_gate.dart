import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Authentication/login/presentation/view/login_page_view.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/view/new_chat_page_view.dart';
import 'core/utils/services/auth_service.dart';
import 'features/splash_screen/presentation/providers/provider.dart';
import 'features/splash_screen/presentation/view/splash_screen.dart';

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  @override
  void initState() {
    super.initState();
    // Start a timer when the widget is initialized
    Timer(const Duration(seconds: 4), () {
      // After 2 seconds, update the provider state
      ref.read(splashTimerProvider.notifier).state = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authStatus = ref.watch(authServiceProvider);
    final splashTimerCompleted = ref.watch(splashTimerProvider);

    print("are you still alive?");
    // Return splash screen if either auth is loading OR minimum time hasn't passed
    if (authStatus is AsyncLoading || !splashTimerCompleted) {
      return SplashScreen();
    }

    // Handle error case
    if (authStatus is AsyncError) {
      print("unexpected error during the auth gate");
      print(authStatus.error);
      return const LoginPageView();
    }

    // Handle data case
    if (authStatus is AsyncData) {
      final status = authStatus.value;
      print("this is the status from the main");
      print(status);

      switch (status) {
        case AuthStatus.authenticated:
          return const NewChatPageView();
        case AuthStatus.notAuthenticated:
          const LoginPageView();
      //1. refresh button
      //2. go to object detection page
      // case AuthStatus.networkError:
      //   WidgetsBinding.instance.addPostFrameCallback((_) {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (_) => const LoginPageView()),
      //     );
      //   });       // case AuthStatus.storageError:
      //   return const LoginPageView(); // Or custom error screen
        break;
        default:
          return const LoginPageView();
      }
    }

    // Fallback
    return const LoginPageView();
  }
}

