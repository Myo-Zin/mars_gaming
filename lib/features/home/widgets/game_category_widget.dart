import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/enum.dart';
import '../../../core/strings.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/route.dart';
import '../../games/widgets/games_by_category_detial_widget.dart';

class GameCategoryWidget extends StatelessWidget {
  const GameCategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 111,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.secondColor)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // AppLocalizations.of(context).ca,
              AppLocalizations.of(context).category,
              style: AppTextStyle.yellowTitle,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImage(
                    AssetString.football,
                      (){
                        goto(
                          context,
                          page:  GamesByCategoryDetailWidget(
                            title: AppLocalizations.of(context).football,
                            gameType: GameType.football,
                          ),
                        );
                      }
                  ),
                  _buildImage(
                    AssetString.cardgame,
                          (){
                            goto(
                              context,
                              page:  GamesByCategoryDetailWidget(
                                title: AppLocalizations.of(context).cardGame,
                                gameType: GameType.card,
                              ),
                            );
                      }
                  ),
                  _buildImage(
                    AssetString.slot,
                          (){
                            goto(
                              context,
                              page:  GamesByCategoryDetailWidget(
                                title: AppLocalizations.of(context).slotGame,
                                gameType: GameType.slot,
                              ),
                            );
                      }
                  ),
                  _buildImage(
                    AssetString.fishing,
                          (){
                            goto(
                              context,
                              page:  GamesByCategoryDetailWidget(
                                title: AppLocalizations.of(context).fishingGame,
                                gameType: GameType.fishing,
                              ),
                            );
                      }
                  ),
                  _buildImage(
                    AssetString.casino,
                          (){
                            goto(
                              context,
                              page:  GamesByCategoryDetailWidget(
                                title: AppLocalizations.of(context).liveCasino,
                                gameType: GameType.casino,
                              ),
                            );
                      }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

   _buildImage(String assetString,Function() onPressed) => Column(
    children: [
      InkWell(
        onTap: onPressed,
        child: Image.asset(
              assetString,
              width: 30,
              height: 30,
              color: AppColor.accentColor,
            ),
      ),
    ],
  );
}
