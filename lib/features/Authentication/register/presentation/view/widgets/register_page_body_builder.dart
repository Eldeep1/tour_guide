import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tour_guide/auth_gate.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/features/Authentication/login/presentation/view/login_page_view.dart';
import 'package:tour_guide/features/Authentication/register/data/models/register_request.dart';
import 'package:tour_guide/features/Authentication/register/presentation/providers/register_form_provider.dart';
import 'package:tour_guide/features/Authentication/register/presentation/providers/register_page_provider.dart';
import 'package:tour_guide/features/Authentication/widgets/form_field_builder.dart';
import 'package:tour_guide/features/Authentication/widgets/main_button_builder.dart';
import 'package:tour_guide/features/Authentication/widgets/text_link_widget.dart';
import 'package:tour_guide/features/Authentication/widgets/txt_header.dart';

class SignUpPageBodyBuilder extends ConsumerStatefulWidget {

  const SignUpPageBodyBuilder({super.key});

  @override
  _SignUpPageBodyBuilderState createState() => _SignUpPageBodyBuilderState();
}

class _SignUpPageBodyBuilderState extends ConsumerState<SignUpPageBodyBuilder> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    final form = ref.watch(registerFormProvider); // Watch the provider
    final nameController = form.nameController;
    final emailController = form.emailController;
    final passwordController = form.passwordController;
    bool passwordVisibility = form.isPasswordVisible;

    return Padding(
      padding: const EdgeInsets.all(screenPadding),
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            // Dismiss the keyboard when tapping outside of form fields
            FocusScope.of(context).unfocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              _buildForm(context, ref, nameController, emailController, passwordController, passwordVisibility),
              _buildAgreeTermsRow(),
              _buildSignUpButton(context, ref, nameController, emailController, passwordController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        txtHeader(context, "Sign up", "Create a new account"),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildForm(BuildContext context, WidgetRef ref, TextEditingController nameController,
      TextEditingController emailController, TextEditingController passwordController, bool passwordVisibility) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          formFieldBuilder(
            validator: validateName,
            label: "Name",
            textEditingController: nameController,
            keyBoardType: TextInputType.name,
          ),
          formFieldBuilder(
            validator: validateEmail,
            label: "Email",
            textEditingController: emailController,
            keyBoardType: TextInputType.emailAddress,
          ),
          formFieldBuilder(
            validator: validatePassword,
            label: "Password",
            textEditingController: passwordController,
            obscureText: !passwordVisibility,
            suffixIcon: Icons.remove_red_eye_outlined,
            suffixIconClick: () => ref.read(registerFormProvider.notifier).togglePasswordVisibility(),
          ),
        ],
      ),
    );
  }

  Widget _buildAgreeTermsRow() {
    return Row(
      children: [
        Checkbox(value: true, onChanged: (value) {}),
        textLinkWidget("I agree to the ", "Terms and Conditions", () {}, context),
      ],
    );
  }

  Widget _buildSignUpButton(BuildContext context, WidgetRef ref, TextEditingController nameController,
      TextEditingController emailController, TextEditingController passwordController) {
    return ref.watch(registerPageProvider).when(
      data: (data) {
        if (data.data != null) {
          ref.invalidate(registerPageProvider);
          _navigateToAuthGate(context);
        }
        return mainButtonBuilder(
          "Sign Up",
          context,
              () => _handleSignUp(ref, nameController, emailController, passwordController),
        );
      },
      error: (error, stackTrace) {
        return Column(
          children: [
            mainButtonBuilder(
              "Sign Up",
              context,
                  () => _handleSignUp(ref, nameController, emailController, passwordController),
            ),
            const SizedBox(height: 8),
            Text(error.toString(), style: const TextStyle(color: Colors.red)),
          ],
        );
      },
      loading: () => Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.amber,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  void _handleSignUp(WidgetRef ref, TextEditingController nameController,
      TextEditingController emailController, TextEditingController passwordController) {
    if (_formKey.currentState?.validate() ?? false) {
      final name = nameController.text;
      final email = emailController.text;
      final password = passwordController.text;
      ref.read(registerPageProvider.notifier).register(
        registerRequest: RegisterRequest(name, email, password),
      );
    }
  }

  void _navigateToAuthGate(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AuthGate()),
              (Route<dynamic> route) => false, // Remove all previous routes
        );

      });
    });
  }
}

// Validation function for email
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

// Validation function for name
String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name is required';
  }
  return null;
}

// Validation function for password
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}
