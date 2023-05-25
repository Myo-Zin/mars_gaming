import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/custom_network_image.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_color.dart';
import '../providers/providers.dart';

class BannerWidget extends ConsumerWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerController = ref.watch(bannerControllerProvider);
    return bannerController.when(
      data: (banners) {
        final images = banners.takeWhile((banner) => banner.mbImage != null);
        return CarouselSlider(
            items: images
                .map(
                  (e) => ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: KNetworkImage(url: e.mbImage!),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              aspectRatio: 18 / 9,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.decelerate,
              enlargeCenterPage: false,
            ));
      },
      error: (error, stackTrace) => AspectRatio(
        aspectRatio: 18 / 9,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: AppColor.secondColor,
          ),
          child: AppErrorWidget(
            error: error,
            onRetry: () {
              ref.invalidate(bannerControllerProvider);
            },
          ),
        ),
      ),
      loading: () => AspectRatio(
        aspectRatio: 18 / 9,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: AppColor.secondColor,
          ),
        ),
      ),
    );
  }
}
