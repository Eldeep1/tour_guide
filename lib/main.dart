import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';

import 'package:tour_guide/features/Authentication/login/presentation/view/login_page_view.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/view/new_chat_page_view.dart';

import 'core/utils/services/auth_service.dart';


void main() {

  runApp(ProviderScope(child: const MyApp()));
  // runApp(ProviderScope(
  //   child: MaterialApp(
  //       theme: lightTheme,
  //       home: ObjectDetectionPage()),
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // TokenOperation tokenOperation=TokenOperationsImp();
    // tokenOperation.deleteTokens();
    return MaterialApp(
      title: 'AI Tour Guide',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      // home: ProviderScope(child:  NewChatPageView(header: "Ask About Anything")),
      // if the token exists, try to get chat headers, if success then access the home page(new chat page)
      // if failed, then access the login page view!

      home: AuthGate(),
    );
  }
}


class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authServiceProvider);

    return authStatus.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) {
        print("unexpected error during the auth gate");
        print(err);
        return const LoginPageView();
      },
      data: (status) {
        print("this is the status from the main");
        print(status);
        switch (status) {
          case AuthStatus.authenticated:
            return const NewChatPageView();
          case AuthStatus.notAuthenticated:
            return const LoginPageView();
            //need to create an offline flag when there's network error, it should contains
        //1. refresh button
        //2. go to object detection page
        // case AuthStatus.networkError:
        //   return const NoInternetScreen(); // Optional screen
        // case AuthStatus.storageError:
        //   return const LoginPageView(); // Or custom error screen
          default:
            return const LoginPageView();
        }
      },
    );
  }
}
