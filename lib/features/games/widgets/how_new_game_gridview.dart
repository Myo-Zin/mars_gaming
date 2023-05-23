import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';
import 'package:super_banners/super_banners.dart';

import '../../../core/enum.dart';
import '../../../core/widgets/custom_network_image.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_color.dart';
import '../../../utils/color_extension.dart';
import '../../../utils/url_constants.dart';
import '../../profile/providers/providers.dart';
import '../../profile/widgets/login_dialog.dart';
import '../providers/providers.dart';
import 'game_girdview.dart';

class HowNewGamesWidget extends ConsumerStatefulWidget {
  final GameType gameType;

  const HowNewGamesWidget({
    super.key,
    required this.gameType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GamesByCategoryState();
}

class _GamesByCategoryState extends ConsumerState<HowNewGamesWidget> {
  @override
  Widget build(BuildContext context) {
    print("game type ${widget.gameType}");
    final gameController = ref.watch(hotNewGameControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameType.name),
      ),
      body: gameController.when(
        data: (games) {
          return games.isEmpty
              ? Container()
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // SizedBox(
                //   height: 50,
                //   child:
                //   NotificationListener<OverscrollIndicatorNotification>(
                //     onNotification:
                //         (OverscrollIndicatorNotification overscroll) {
                //       overscroll.disallowIndicator();
                //       return true;
                //     },
                //     child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       // shrinkWrap: true,
                //       itemCount: games.length,
                //       itemBuilder: (context, index) => CategoryTabImage(
                //         games: games[index],
                //         gameType: widget.gameType,
                //         isIndexOne: index == 0,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 18,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: TextField(
                    controller: ref.watch(
                      searchTextEditingControllerProvider(widget.gameType),
                    ),
                    decoration: InputDecoration(
                      hintText: "Search game",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.accentColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref
                              .read(
                            searchTextEditingControllerProvider(
                                widget.gameType),
                          )
                              .clear();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18,),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: games.length,
                    scrollDirection: Axis.vertical,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 160,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          final auth = ref.read(profileControllerProvider);
                          auth.maybeMap(
                            data: (value) async {
                              final turnover = double.parse(
                                  value.profileData.turnover ?? '0.0');
                              if (turnover > 0) {
                                if (widget.gameType == GameType.slot ||
                                    widget.gameType == GameType.fishing) {
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
                                    fontSize: 12.0, fontWeight: FontWeight.bold),
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
          );
        },
        error: (error, stackTrace) {
          return AppErrorWidget(
            error: error,
            onRetry: () {
              ref.refresh(gameCategoryControllerProvider(widget.gameType));
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}