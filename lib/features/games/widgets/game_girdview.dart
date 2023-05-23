import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';

import '../../../core/enum.dart';
import '../../../core/widgets/custom_network_image.dart';
import '../../../utils/app_color.dart';
import '../../profile/providers/providers.dart';
import '../../profile/widgets/login_dialog.dart';
import '../models/games_by_id_param.dart';
import '../providers/providers.dart';


class GameGridViewWidget extends ConsumerWidget {
  final GameType gameType;

  const GameGridViewWidget({
    required this.gameType,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategoryId = ref.watch(selectedCategoryNotifier(gameType));

    final games = ref.watch(
      searchGamesByCategoryIdProvider(
        GameByCategoryIdParam(
          gameType: gameType,
          categoryId: selectedCategoryId,
        ),
      ),
    );

    return LayoutBuilder(builder: (context, constraints){

      return GridView.extent(
        padding: const EdgeInsets.all(10),
       // itemCount: games.length,
        scrollDirection: Axis.vertical,
       // gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
       //    crossAxisCount:  constraints.maxWidth > 700 ? 4 : 3,
       //    mainAxisExtent: 130,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.8,
          maxCrossAxisExtent: 150,
          children: games.map((game) => GestureDetector(
            onTap: () {
              final auth = ref.read(profileControllerProvider);
              auth.maybeMap(
                data: (value) async {
                  final turnover =
                  double.parse(value.profileData.turnover ?? '0.0');
                  if (turnover > 0) {
                    if (gameType == GameType.slot ||
                        gameType == GameType.fishing) {
                      await ref.read(gameViewController.notifier).getGameViewUrl(
                        token: value.profileData.token!,
                        userId: value.profileData.id!,
                        gameCode: game.gCode!,
                        context: context,
                      );
                    } else {
                      context.showErrorSnackbar("You need to have turn over 0!");
                    }
                  } else {
                    await ref.read(gameViewController.notifier).getGameViewUrl(
                      token: value.profileData.token!,
                      userId: value.profileData.id!,
                      gameCode: game.gCode!,
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
            child: Column(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.accentColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: KNetworkImage(
                        url: game.img!,
                        needPrefix: game.img!.startsWith("/")
                            ? true
                            : false,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${game.name}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12.0, fontWeight: FontWeight.bold),
                  maxLines: 2,
                )
              ],
            ),
          )).toList(),
       // ),
        //itemBuilder: (context, index) {
          // return GestureDetector(
          //   onTap: () {
          //     final auth = ref.read(profileControllerProvider);
          //     auth.maybeMap(
          //       data: (value) async {
          //         final turnover =
          //         double.parse(value.profileData.turnover ?? '0.0');
          //         if (turnover > 0) {
          //           if (gameType == GameType.slot ||
          //               gameType == GameType.fishing) {
          //             await ref.read(gameViewController.notifier).getGameViewUrl(
          //               token: value.profileData.token!,
          //               userId: value.profileData.id!,
          //               gameCode: games[index].gCode!,
          //               context: context,
          //             );
          //           } else {
          //             context.showErrorSnackbar("You need to have turn over 0!");
          //           }
          //         } else {
          //           await ref.read(gameViewController.notifier).getGameViewUrl(
          //             token: value.profileData.token!,
          //             userId: value.profileData.id!,
          //             gameCode: games[index].gCode!,
          //             context: context,
          //           );
          //         }
          //       },
          //       unAuthenticated: (_) {
          //         loginDialog(context);
          //       },
          //       orElse: () {},
          //     );
          //   },
          //   child: Column(
          //     children: [
          //       Container(
          //         height: 80,
          //         decoration: BoxDecoration(
          //           border: Border.all(color: AppColor.accentColor),
          //           borderRadius: BorderRadius.circular(5),
          //         ),
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.circular(5),
          //           child: SizedBox(
          //             width: double.infinity,
          //             height: double.infinity,
          //             child: KNetworkImage(
          //               url: games[index].img!,
          //               needPrefix: games [index].img!.startsWith("/")
          //                   ? true
          //                   : false,
          //               fit: BoxFit.fill,
          //             ),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 4,
          //       ),
          //       Text(
          //         "${games[index].name}",
          //         textAlign: TextAlign.center,
          //         style: const TextStyle(
          //             fontSize: 12.0, fontWeight: FontWeight.bold),
          //         maxLines: 2,
          //       )
          //     ],
          //   ),
          // );
       // },
      );
    }
     // child:
    );
  }
}
