import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../core/strings.dart';
import '../../../utils/app_color.dart';

class MyTab extends SliverPersistentHeaderDelegate {
  final TabController controller;
  MyTab(this.controller);
  @override
  Widget build(BuildContext context, shrinkOffset, overlapsContent) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.secondColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TabBar(
        onTap: (value) {
          tabarIndexNotifier.value = value;
        },
        controller: controller,
        indicator: RectangularIndicator(
          color: AppColor.accentColor,
          topLeftRadius: 10,
          topRightRadius: 10,
          bottomLeftRadius: 10,
          bottomRightRadius: 10,
        ),
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
        unselectedLabelColor: AppColor.accentColor,
        tabs: const [
          Tab(
            child: TabImage(
              image: AssetString.menu,
              index: 0,
            ),
          ),
          Tab(
            child: TabImage(
              image: AssetString.football,
              index: 1,
            ),
          ),
          Tab(
            child: TabImage(
              image: AssetString.cardgame,
              index: 2,
            ),
          ),
          Tab(
            child: TabImage(
              image: AssetString.slot,
              index: 3,
            ),
          ),
          Tab(
            child: TabImage(
              image: AssetString.fishing,
              index: 4,
            ),
          ),
          Tab(
            child: TabImage(
              image: AssetString.casino,
              index: 5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  double maxExtent = 60;
  @override
  double minExtent = 60;
}

final tabarIndexNotifier = ValueNotifier<int>(0);

class TabImage extends StatelessWidget {
  final String image;
  final int index;
  const TabImage({
    super.key,
    required this.image,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: tabarIndexNotifier,
      builder: (context, value, child) {
        return Image.asset(
          image,
          color: value == index ? AppColor.textColor : AppColor.accentColor,
          width: 30,
          height: 30,
        );
      },
    );
  }
}
