import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/url_constants.dart';

class KNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final bool needPrefix;
  final Color? color;
  final bool addPlaceHolader;
  const KNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.needPrefix = true,
    this.color,
    this.addPlaceHolader = false,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Image.network(
        needPrefix ? UrlConst.imagePrefix + url : url,
        fit: fit,
        color: color,
        loadingBuilder: addPlaceHolader
            ? (context, child, loadingProgress) => const AspectRatio(
          aspectRatio: 1,
        )
            : null,
        errorBuilder: (context, error, stackTrace) =>
        const Center(child: Icon(Icons.error_outline)),
      );
    }
    return CachedNetworkImage(
      imageUrl: needPrefix ? UrlConst.imagePrefix + url : url,
      fit: fit,
      color: color,
      placeholder: addPlaceHolader
          ? (context, url) => const AspectRatio(
        aspectRatio: 1,
      )
          : null,
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error_outline),
      ),
    );
  }
}