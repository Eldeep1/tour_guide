
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/constants.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/features/Authentication/register/presentation/view/register_page_view.dart';
import 'package:tour_guide/features/Authentication/widgets/main_button_builder.dart';
import 'package:tour_guide/features/Authentication/widgets/text_link_widget.dart';
import 'package:tour_guide/features/Authentication/widgets/txt_header.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/view/new_chat_page_view.dart';
import '../../../../widgets/form_field_builder.dart';

Widget pageBodyBuilder(context,itemsWidth)=>Padding(
  padding: const EdgeInsets.all(screenPadding),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      txtHeader(context,"Sign in","Log in to your account"),
      formFieldBuilder("Email",width: itemsWidth),
      formFieldBuilder("password",width: itemsWidth),
      mainButtonBuilder("Sign in",context, (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProviderScope(child: NewChatPageView(header: newChatMessage,)),));}),
      textLinkWidget("New Tourist?"," Create New Account",(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
      },context),
    ],
  ),
);
