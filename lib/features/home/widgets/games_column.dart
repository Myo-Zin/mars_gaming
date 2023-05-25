import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/enum.dart';
import '../../../core/widgets/disable_scroll_effect_widget.dart';
import '../../../utils/route.dart';
import '../../games/widgets/game_listview.dart';
import '../../games/widgets/games_by_category_detial_widget.dart';
import 'lottery_widget.dart';

class HomeGameMenu extends StatelessWidget {
  const HomeGameMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return DisbleScrollEffectWidget(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            const LotteryListViewWidget(),
            GameListViewWidget(
              title: AppLocalizations.of(context).football,
              gameType: GameType.football,
              onTap: () {
                goto(
                  context,
                  page: GamesByCategoryDetailWidget(
                    title: AppLocalizations.of(context).football,
                    gameType: GameType.football,
                  ),
                );
              },
            ),
            GameListViewWidget(
              title: AppLocalizations.of(context).cardGame,
              gameType: GameType.card,
              onTap: () {
                goto(
                  context,
                  page: GamesByCategoryDetailWidget(
                    title: AppLocalizations.of(context).cardGame,
                    gameType: GameType.card,
                  ),
                );
              },
            ),
            //  HotNewGameListViewWidget(
            //   title: "New Games",
            //   gameType: GameType.hotNew,
            //   onTap: (){
            //     goto(
            //       context,
            //       page: const HowNewGamesWidget(
            //         gameType: GameType.hotNew,
            //       ),
            //     );
            //   },
            //
            // ),
            GameListViewWidget(
              title: AppLocalizations.of(context).slotGame,
              gameType: GameType.slot,
              onTap: () {
                goto(
                  context,
                  page: GamesByCategoryDetailWidget(
                    title: AppLocalizations.of(context).slotGame,
                    gameType: GameType.slot,
                  ),
                );
              },
            ),
            GameListViewWidget(
              title: AppLocalizations.of(context).fishingGame,
              gameType: GameType.fishing,
              onTap: () {
                goto(
                  context,
                  page: GamesByCategoryDetailWidget(
                    title: AppLocalizations.of(context).fishingGame,
                    gameType: GameType.fishing,
                  ),
                );
              },
            ),
            GameListViewWidget(
              title: AppLocalizations.of(context).liveCasino,
              gameType: GameType.casino,
              onTap: () {
                goto(
                  context,
                  page: GamesByCategoryDetailWidget(
                    title: AppLocalizations.of(context).liveCasino,
                    gameType: GameType.casino,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
