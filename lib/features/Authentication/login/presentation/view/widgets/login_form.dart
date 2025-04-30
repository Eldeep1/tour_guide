import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';
import 'package:tour_guide/core/utils/services/validators/validators.dart';
import 'package:tour_guide/features/Authentication/login/data/models/login_request.dart';
import 'package:tour_guide/features/Authentication/login/presentation/providers/login_page_provider.dart';
import 'package:tour_guide/features/Authentication/widgets/form_field_builder.dart';
import 'package:tour_guide/features/Authentication/widgets/main_button_builder.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/view/new_chat_page_view.dart';

/// Use ConsumerStatefulWidget & ConsumerState
class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Track password visibility
  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = ref.watch(loginPageProvider);
    final loginProviderData = ref.read(loginPageProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              formFieldBuilder(
                textEditingController: _emailController,
                label: 'Email',
                prefixIcon: Icons.email_outlined,
                keyBoardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
                focusNode: _emailFocusNode,
              ),
              formFieldBuilder(
                textEditingController: _passwordController,
                label: "Password",
                obscureText: !_passwordVisible,
                suffixIconClick: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                suffixIcon: Icons.remove_red_eye_outlined,
                validator: Validators.validatePassword,
                focusNode: _passwordFocusNode,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        // Move the button builder here directly
        loginButton(_emailController, _passwordController, _formKey)
      ],
    );
  }
}
Widget loginButton(TextEditingController emailController, TextEditingController passwordController,formKey) {

  return Consumer(builder: (context, ref, child) {
    final loginProvider = ref.watch(loginPageProvider);
    final loginProviderData = ref.read(loginPageProvider.notifier);
   return         loginProvider.when(
     data: (loginResponse) {
       print("and that's why we are on that shit");
       print(loginResponse.refreshToken);
       print(ref.read(isLoggingOutProvider));
       if (loginResponse.refreshToken.isNotEmpty && !ref.read(isLoggingOutProvider)) {
         print("and we have pushed");
         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewChatPageView(),));
         },);
       }
       return mainButtonBuilder(
         "Sign in",
         context,
             () {
           if(formKey.currentState!.validate()){
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
  },);
}