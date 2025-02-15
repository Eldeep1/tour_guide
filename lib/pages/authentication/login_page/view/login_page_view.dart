import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tour_guide/pages/chat_page/view/chat_page_view.dart';
import 'package:tour_guide/services/components/constants/constants.dart';
import 'package:tour_guide/services/components/themes/light_theme.dart';

import '../../shared/components/shared_Auth_UI.dart';
import '../../sign_up/view/sign_up_page.dart';

class LoginPageView extends ConsumerWidget {
  const LoginPageView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(

      body: SafeArea(

        child: LayoutBuilder(builder: (context, constraints) {
          if(constraints.maxWidth>largeScreenSize){
            double itemsWidth=constraints.maxWidth/3;
            return Row(
              children: [
                Expanded(
                  child: pageBodyBuilder(context,itemsWidth),
                ),
                Expanded(child: backgroundImage(1))
              ],
            );
          }
          else{
            double itemsWidth=constraints.maxWidth/2;
            return Stack(
              children: [
                backgroundImage(.5),
                pageBodyBuilder(context,itemsWidth),
              ],
            );
          }
        },),
      ),

    );
  }



  Widget pageBodyBuilder(context,itemsWidth)=>Padding(
    padding: const EdgeInsets.all(screenPadding),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        txtHeader(context,"Sign in","Log in to your account"),
        formFieldBuilder("Email",width: itemsWidth),
        formFieldBuilder("password",width: itemsWidth),
        signButtonBuilder("Sign in",context, (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProviderScope(child: ChatPageView(chatID: null,)),));}),
        textLinkWidget("New Tourist?"," Create New Account",(){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
        },context),
      ],
    ),
  );

}