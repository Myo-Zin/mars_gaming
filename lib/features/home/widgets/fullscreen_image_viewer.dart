import 'package:flutter/material.dart';


import '../../../core/widgets/custom_network_image.dart';

showQrCode(BuildContext context, String image) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: KNetworkImage(url: image),
      );
    },
  );
}
