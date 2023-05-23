import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../core/strings.dart';
import '../models/social_link_response.dart';
import 'fullscreen_image_viewer.dart';

class SocialLinkWidget extends StatelessWidget {
  final SocialLinks social;
  const SocialLinkWidget({
    super.key,
    required this.social,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 100,
      children: [
        _Contact(
          link: social.facebook,
          image: AssetString.facebook,
        ),
        _Contact(
          link: social.messenger,
          image: AssetString.messenger,
        ),
        _Contact(
          link: social.instagram,
          image: AssetString.instagram,
        ),
        _Contact(
          link: social.viber,
          image: AssetString.viber,
        ),
        _Contact(
          link: social.qr,
          image: AssetString.qrcode,
        ),
      ],
    );
  }
}

class _Contact extends StatelessWidget {
  final String? link;
  final String image;

  const _Contact({
    required this.link,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    if (link == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          if (image == AssetString.qrcode && link != null) {
            showQrCode(context, link!);
          } else {
            if (await launchUrl(Uri.parse(link!))) {
              launchUrl(Uri.parse(link!),
                  mode: LaunchMode.externalNonBrowserApplication);
            }
          }
        },
        child: SizedBox(
          width: mediaWidth / 5,
          height: mediaWidth / 5,
          child: Image.asset(image),
        ),
      ),
    );
  }
}
