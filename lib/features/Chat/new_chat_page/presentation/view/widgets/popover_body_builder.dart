import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/utils/services/auth_service.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        Row(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {

                  return TextButton(
                    onPressed: (){

                      ref.read(authServiceProvider.notifier).logOut();
                      Navigator.of(context, rootNavigator: true).pop();
                      print(ref.read(authServiceProvider));
                    }, child: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  );
                },
              ),
            ),
          ],
        ),

      ],
    );
  }
}
