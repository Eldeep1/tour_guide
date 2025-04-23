import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tour_guide/features/Authentication/login/data/models/login_request.dart';
import 'package:tour_guide/features/Authentication/login/presentation/providers/login_page_provider.dart';
import 'package:tour_guide/features/Authentication/widgets/form_field_builder.dart';
import 'package:tour_guide/features/Authentication/widgets/main_button_builder.dart';

import '../../providers/text_field_controllers.dart';

class LoginForm extends ConsumerWidget {
  final double itemsWidth;

  const LoginForm({super.key, required this.itemsWidth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    final loginProvider = ref.watch(loginPageProvider);
    final loginProviderData = ref.read(loginPageProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        formFieldBuilder(
          textEditingController: emailController,
          width: itemsWidth,
          label: 'Email',
          prefixIcon: Icons.email_outlined,
        ),
        formFieldBuilder(
          textEditingController: passwordController,
          width: itemsWidth,
          label: "Password",
        ),
        const SizedBox(height: 12),
        loginProvider.when(
          data: (_) => mainButtonBuilder(
            "Sign in",
            context,
                () {
              loginProviderData.login(
                loginRequest: LoginRequest(
                  emailController.text,
                  passwordController.text,
                ),
              );
            },
          ),
          loading: () => Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.amber,
            child: const CircularProgressIndicator(),
          ),
          error: (error, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mainButtonBuilder("Sign in", context, () {
                loginProviderData.login(
                  loginRequest: LoginRequest(
                    emailController.text,
                    passwordController.text,
                  ),
                );
              }),
              const SizedBox(height: 8),
              Text(error.toString(), style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}