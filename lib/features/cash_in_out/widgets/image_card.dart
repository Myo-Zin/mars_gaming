
import 'package:flutter/material.dart';

import '../../../utils/url_constants.dart';

class ImageCard extends StatelessWidget {
  final String? image;
  const ImageCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              child: ClipRRect(
                borderRadius:const BorderRadius.all(Radius.circular(7)),
                child: Image.network('${UrlConst.imagePrefix}$image',fit: BoxFit.cover,)
      ),
    );
  }
}