import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class KAnimatedText extends StatelessWidget {
  const KAnimatedText(
    this.text, {
    super.key,
    this.style,
  });
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        FadeAnimatedText(text, textStyle: style),
      ],
    );
  }
}
