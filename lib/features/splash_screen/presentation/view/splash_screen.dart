import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tour_guide/constants.dart';
import 'package:tour_guide/core/utils/Assets/assets.dart' ;
import 'package:tour_guide/features/splash_screen/presentation/view/widgets/delayed_text.dart';

import '../../../../core/utils/services/auth_service.dart';

class SplashScreen extends ConsumerWidget{
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(authServiceProvider);
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            backgroundGradient,
            Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Lottie.asset(Assets.splashScreen,repeat: true)),
                AnimatedTextKit(
                  repeatForever: false,
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TyperAnimatedText("AI Tour-Guide",textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),
                    ]
                ),
                const SizedBox(height: 20),
                // This will appear after 1 second
                const DelayedAnimatedText(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}