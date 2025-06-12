import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tour_guide/core/utils/services/auth_service.dart';
import 'package:tour_guide/features/Authentication/login/data/models/login_request.dart';
import 'package:tour_guide/features/Authentication/login/presentation/providers/login_page_provider.dart';
import 'package:tour_guide/features/Authentication/widgets/main_button_builder.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/view/new_chat_page_view.dart';

class LoginButtonBuilder extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode passwordFocusNode ;
  final FocusNode emailFocusNode ;
  const LoginButtonBuilder({super.key,required this.formKey,required this.emailController,required this.passwordController,required this.passwordFocusNode,required this.emailFocusNode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginProvider = ref.watch(loginPageProvider);
    final loginProviderData = ref.read(loginPageProvider.notifier);

    return         loginProvider.when(
      data: (loginResponse) {
        if (ref.read(authServiceProvider).value==AuthStatus.authenticated) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewChatPageView(),));
          },);
        }
        return mainButtonBuilder(
          "Sign in",
          context,
              () {
            if(formKey.currentState!.validate()){
              emailFocusNode.unfocus();
              passwordFocusNode.unfocus();
              loginProviderData.login(
                loginRequest: LoginRequest(
                  emailController.text,
                  passwordController.text,
                ),
              );
            }
          },
        );
      },
      loading: () => Center(
        child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.amber,
          child: const CircularProgressIndicator(),
        ),
      ),
      error: (error, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mainButtonBuilder(
            "Sign in",
            context,
                () {
              if(formKey.currentState!.validate()){
                emailFocusNode.unfocus();
                passwordFocusNode.unfocus();
                loginProviderData.login(
                  loginRequest: LoginRequest(
                    emailController.text,
                    passwordController.text,
                  ),
                );
              }

            },
          ),
          const SizedBox(height: 8),
          Text(error.toString(), style: const TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}
