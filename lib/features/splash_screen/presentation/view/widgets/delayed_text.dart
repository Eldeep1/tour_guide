import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class DelayedAnimatedText extends StatelessWidget {
  const DelayedAnimatedText({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a Future that completes after 1 second
    final Future<bool> delayFuture = Future.delayed(
      const Duration(seconds: 1),
          () => true,
    );

    return FutureBuilder<bool>(
      future: delayFuture,
      builder: (context, snapshot) {
        // Show nothing while waiting for the delay to complete
        if (!snapshot.hasData) {
          return const SizedBox(height: 30,);
        }

        // After delay completes, show the AnimatedTextKit
        return AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [

            FlickerAnimatedText(
              "GP 911",
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
            ),
          ],
        );
      },
    );
  }
}