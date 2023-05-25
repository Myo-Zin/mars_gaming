import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';
import 'package:super_banners/super_banners.dart';

import '../../../core/enum.dart';
import '../../../core/widgets/custom_network_image.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/color_extension.dart';
import '../../../utils/url_constants.dart';
import '../../profile/providers/providers.dart';
import '../../profile/widgets/login_dialog.dart';
import '../providers/providers.dart';

class HotNewGameListViewWidget extends ConsumerWidget {
  final String title;
  final GameType gameType;
  final Function() onTap;
  const HotNewGameListViewWidget({
    required this.title,
    required this.gameType,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameController = ref.watch(hotNewGameControllerProvider);
    return gameController.when(
      data: (games) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            // margin: const EdgeInsets.symmetric(
            //   vertical: 8.0,
            //   horizontal: 8.0,
            // ),
            height: 220,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.secondColor)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyle.yellowTitle,
                        ),
                      ),
                      TextButton(onPressed: onTap, child: const Text("More>>"))
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: games.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            final auth = ref.read(profileControllerProvider);
                            auth.maybeMap(
                              data: (value) async {
                                final turnover = double.parse(
                                    value.profileData.turnover ?? '0.0');
                                if (turnover > 0) {
                                  if (gameType == GameType.slot ||
                                      gameType == GameType.fishing) {
                                    await ref
                                        .read(gameViewController.notifier)
                                        .getGameViewUrl(
                                          token: value.profileData.token!,
                                          userId: value.profileData.id!,
                                          gameCode: games[index].gCode!,
                                          context: context,
                                        );
                                  } else {
                                    context.showErrorSnackbar(
                                        "You need to have turn over 0!");
                                  }
                                } else {
                                  await ref
                                      .read(gameViewController.notifier)
                                      .getGameViewUrl(
                                        token: value.profileData.token!,
                                        userId: value.profileData.id!,
                                        gameCode: games[index].gCode!,
                                        context: context,
                                      );
                                }
                              },
                              unAuthenticated: (_) {
                                loginDialog(context);
                              },
                              orElse: () {},
                            );
                          },
                          child: SizedBox(
                            width: 130,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: AppColor.secondColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 117,
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: KNetworkImage(
                                          url:
                                              "${UrlConst.imagePrefix}storage/games/${games[index].img!}",
                                          needPrefix: false,
                                          addPlaceHolader: true,
                                        ),
                                      ),
                                      CornerBanner(
                                        bannerPosition:
                                            CornerBannerPosition.topLeft,
                                        bannerColor: HexColor.fromHex("AA2E26"),
                                        shadowColor: Colors.grey,
                                        elevation: 5,
                                        child: Text(
                                          "NEW",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: HexColor.fromHex("F6DD8A"),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "${games[index].name}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) => Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: AppColor.secondColor,
        ),
        child: AppErrorWidget(
          error: error,
          onRetry: () {
            ref.invalidate(hotNewGameControllerProvider);
          },
        ),
      ),
      loading: () => _GameListViewLoadingWidget(title: title),
    );
  }
}

class _GameListViewLoadingWidget extends StatelessWidget {
  const _GameListViewLoadingWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        // color: Colors.red,
        // margin: const EdgeInsets.symmetric(
        //   vertical: 8.0,
        //   horizontal: 8.0,
        // ),
        height: 227,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.secondColor)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyle.yellowTitle,
                    ),
                  ),
                  TextButton(onPressed: () {}, child: const Text("More>>"))
                ],
              ),
              const SizedBox(height: 4),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return SizedBox(
                        width: 130,
                        child: Container(
                          // padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: AppColor.secondColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 117,
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //   Container(
    //   margin: const EdgeInsets.symmetric(
    //     // vertical: 15.0,
    //     // horizontal: 15.0,
    //   ),
    //   height: 220,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10),
    //       border: Border.all(color: AppColor.secondColor)
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.only(left: 8.0),
    //         child: Text(
    //           title,
    //           style: AppTextStyle.yellowTitle,
    //         ),
    //       ),
    //       const SizedBox(height: 20),
    //       Expanded(
    //         child: ListView.builder(
    //           scrollDirection: Axis.horizontal,
    //           itemCount: 4,
    //           itemBuilder: (context, index) {
    //             return AspectRatio(
    //               aspectRatio: 1,
    //               child: Container(
    //                 padding: const EdgeInsets.all(8),
    //                 margin: const EdgeInsets.only(right: 10),
    //                 decoration: BoxDecoration(
    //                   color: AppColor.secondColor,
    //                   borderRadius: BorderRadius.circular(10),
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
