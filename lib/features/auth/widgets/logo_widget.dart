import 'package:flutter/material.dart';

import '../../../core/strings.dart';


class LogoImageWidget extends StatelessWidget {
  const LogoImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetString.logo,
      width: 200,
      height: 200,
    );
  }
}
