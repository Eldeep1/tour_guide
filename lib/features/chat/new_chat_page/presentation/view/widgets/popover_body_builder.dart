import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/themes/dark/dark_theme.dart';
import 'package:tour_guide/core/themes/theme_provider.dart';
import 'package:tour_guide/core/utils/services/auth_service.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';
import 'package:tour_guide/features/authentication/login/presentation/view/login_page_view.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // editProfileButtonBuilder(context, function: (){}, text: "Edit profile"),
        Row(
          children: [
            SizedBox(width: 12,),
            Text('Dark Mode', style: Theme.of(context).textTheme.bodyMedium),

            Spacer(),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return Transform.scale(
                  scale: .6,
                  child: Switch(// Move switch to the start
                    padding: EdgeInsets.zero,
                    value: ref.watch(themeProvider.notifier).themeData==darkTheme,
                    onChanged: (val) {
                      Navigator.of(context, rootNavigator: true).pop();

                      ref.read(themeProvider.notifier).changeTheme();
                    },

                    activeColor: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),

        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return logoutButtonBuilder(context, function: (){
              ref.read(isLoggingOutProvider.notifier).state = true;
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPageView(),));
              ref.read(authServiceProvider.notifier).logOut();
            }, text: "Logout");
          },
        ),
      ],
    );
  }
}

Widget logoutButtonBuilder(context,{
  required void Function()? function,
  required String text,
}){
  return  Row(
    children: [
      Expanded(child: TextButton(
        onPressed: function, child: Row(
          children: [
            Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
                  ),
            Spacer(),

            Icon(Icons.logout,color: Colors.white,),
          ],
        ),
      )),
    ],
  );
}
Widget editProfileButtonBuilder(context,{
  required void Function()? function,
  required String text,
}){
  return  Row(
    children: [
      Expanded(child: TextButton(
        onPressed: function, child: Row(
          children: [
            Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
                  ),
            Spacer(),
            Icon(Icons.edit_outlined,color: Colors.white,),
          ],
        ),
      )),
    ],
  );
}
