import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:tour_guide/constants.dart';
import 'package:tour_guide/core/utils/services/auth_service.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/view/new_chat_page_view.dart';

import '../../../widgets/back_ground_image.dart';
import '../providers/login_page_provider.dart';
import 'widgets/login_page_body.dart';

class LoginPageView extends ConsumerWidget {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(loginPageProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (data.refreshToken.isNotEmpty) {
            print(data.refreshToken);
            print("alooooooo");
            print(ref.read(authServiceProvider).value);
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const NewChatPageView(),
            //   ),
            // );
          }
        },
        error: (error, _) {
          Fluttertoast.showToast(
            msg: error.toString(),
            backgroundColor: Colors.red,
          );
        },
      );
    });

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double itemsWidth = constraints.maxWidth > largeScreenSize
                ? constraints.maxWidth / 3
                : constraints.maxWidth / 2;

            Widget body = Center(child: pageBodyBuilder(context, itemsWidth));

            return constraints.maxWidth > largeScreenSize
                ? Row(
              children: [
                Expanded(child: body),
                Expanded(child: backgroundImage(1)),
              ],
            )
                : Stack(
              children: [
                // backgroundImage(.5),
            Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff000412), Color(0xff070E26), Colors.deepPurple,],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            ),),
                body,
              ],
            );
          },
        ),
      ),
    );
  }
}
