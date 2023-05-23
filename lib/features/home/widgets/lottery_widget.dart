import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/strings.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/route.dart';
import '../../2d/pages/two_d_lucky_number_page.dart';
import '../../3d/pages/three_d_lucky_number_page.dart';
import '../../crypto2d/pages/crypto_two_d_lucky_number_page.dart';


class LotteryListViewWidget extends ConsumerWidget {
  const LotteryListViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(
        // vertical: 15.0,
        // horizontal: 15.0,
      ),
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.secondColor)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).lottery,
              style: AppTextStyle.yellowTitle,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                    onTap: () {
                      goto(context, page: const CryptoTwoDLuckyNumberPage());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: AppColor.accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(AssetString.crypto),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      goto(context, page: const TwoDLuckyNumberPage());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: AppColor.accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(AssetString.twoD),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      goto(context, page: const ThreeDLuckyNumberPage());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: AppColor.accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(AssetString.threeD),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
