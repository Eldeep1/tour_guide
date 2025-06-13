
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tour_guide/core/themes/dark/dark_theme.dart';
import 'package:tour_guide/core/utils/Assets/assets.dart';

import 'delayed_text.dart';

class SplashScreenBodyBuilder extends StatelessWidget{
  const SplashScreenBodyBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            backgroundGradient(),
            Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Lottie.asset(Assets.splashScreen,repeat: true)),
                AnimatedTextKit(
                    repeatForever: false,
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TyperAnimatedText("AI Tour-Guide",textStyle: Theme.of(context).textTheme.bodyMedium),
                    ]
                ),
                const SizedBox(height: 20),

                const DelayedAnimatedText(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}