import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enum.dart';
import '../../../core/strings.dart';
import '../../../l10n/util.dart';
import '../../../utils/app_color.dart';
import '../../../utils/route.dart';
import '../../../utils/url_constants.dart';
import '../../2d/pages/two_d_betslips_page.dart';
import '../../3d/pages/three_d_bet_slips_page.dart';
import '../../auth/providers/providers.dart';
import '../../crypto2d/pages/crypto_two_d_betslips_page.dart';
import '../../games/pages/game_report_page.dart';
import '../../games/widgets/games_by_category_detial_widget.dart';
import '../../profile/pages/upload_leve_2_photo_page.dart';
import '../../profile/providers/profile_image_controller.dart';
import '../../profile/providers/providers.dart';
import '../../profile/widgets/logout_dialog.dart';
import '../../profile/widgets/profile_image_widget.dart';
import '../../winners_list/page/winner_list_page.dart';
import '../providers/nav_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/persistance_tabbar.dart';
import 'first_page.dart';

class DrawerPage extends ConsumerStatefulWidget {
  const DrawerPage(
    this._controller, {
    Key? key,
  }) : super(key: key);
  final TabController _controller;

  @override
  ConsumerState<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends ConsumerState<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    final profileController = ref.watch(profileControllerProvider);
    final localImage = ref.watch(profileImagePickControllerProvider);
    return Drawer(
      backgroundColor: AppColor.mainColor,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: buildIcon(Icons.close_rounded)),
                const SizedBox(
                  width: 8,
                ),
                buildText("Close")
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            profileController.map(
              unAuthenticated: (_) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(naviIndexControllerProvider.notifier)
                          .changeIndex(4);
                      Navigator.pop(context);
                    },
                    child: const Text("Login"),
                  ),
                );
              },
              data: (data) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                        // elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.only(top: 8),
                            child: Column(
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 2,
                                        color: AppColor.accentColor,
                                      ),
                                      image: localImage == null
                                          ? data.profileData.image != null
                                              ? DecorationImage(
                                                  image: NetworkImage(UrlConst
                                                          .imagePrefix +
                                                      data.profileData.image!),
                                                  fit: BoxFit.cover,
                                                )
                                              : null
                                          : DecorationImage(
                                              image: FileImage(localImage),
                                              fit: BoxFit.cover)),
                                  child: data.profileData.image == null
                                      ? localImage == null
                                          ? Icon(
                                              CupertinoIcons.person,
                                              color: AppColor.accentColor,
                                              size: 40,
                                            )
                                          : null
                                      : null,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${AppLocalizations.of(context).level} : ${data.profileData.lvl2 == 0 ? 1 : 2}',
                                      style: const TextStyle(
                                        //color: AppColor.accentColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.center,
                                    //   children: [
                                    //     Text(
                                    //       'ID : ${data.profileData.userCode}',
                                    //       style: const TextStyle(
                                    //         // color: AppColor.accentColor,
                                    //         fontSize: 15,
                                    //       ),
                                    //     ),
                                    //     IconButton(
                                    //       onPressed: () {
                                    //         Clipboard.setData(ClipboardData(
                                    //                 text: data
                                    //                     .profileData.userCode))
                                    //             .then((_) {
                                    //           ScaffoldMessenger.of(context)
                                    //               .showSnackBar(SnackBar(
                                    //                   content: Text(
                                    //                       "Copied to clipboard ${data.profileData.userCode}")));
                                    //         });
                                    //       },
                                    //       icon: const Icon(
                                    //         Icons.copy,
                                    //         // color: AppColor.accentColor,
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                data.profileData.lvl2 == 0
                                    ? InkWell(
                                        onTap: () {
                                          goto(context,
                                              page: UploadLevelTwoPhotoPage(
                                                  data.profileData));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.accentColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              top: 4,
                                              bottom: 4,
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .upgradeLevel,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const Text(''),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ))),
                  ],
                );
              },
              error: (error) {
                return Center(
                  child: Text(error.message),
                );
              },
              loading: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            Card(
              // elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: buildIcon(CupertinoIcons.profile_circled),
                    title: buildText(AppLocalizations.of(context).profile),
                    onTap: () {
                      ref
                          .read(naviIndexControllerProvider.notifier)
                          .changeIndex(4);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: buildIcon(CupertinoIcons.phone_circle),
                    title: buildText(AppLocalizations.of(context).contact),
                    onTap: () {
                      ref
                          .read(naviIndexControllerProvider.notifier)
                          .changeIndex(3);
                      Navigator.pop(context);
                    },
                  ),

                  if(showWallet)  ListTile(
                    leading: buildIcon(
                      Icons.shop,
                    ),
                    title: buildText(AppLocalizations.of(context).wallet),
                    onTap: () {
                      ref
                          .read(naviIndexControllerProvider.notifier)
                          .changeIndex(2);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: buildIcon(
                      CupertinoIcons.speaker_fill,
                    ),
                    title: buildText(AppLocalizations.of(context).promotion),
                    onTap: () {
                      ref
                          .read(naviIndexControllerProvider.notifier)
                          .changeIndex(1);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            Card(
              //elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: buildImage(AssetString.football),
                    title: buildText(AppLocalizations.of(context).football),
                    onTap: () {
                      // setState(() {
                      //   widget._controller.index = 1;
                      //   tabarIndexNotifier.value = 1;
                      // });
                      // Navigator.pop(context);
                      Navigator.pop(context);
                      goto(
                        context,
                        page: GamesByCategoryDetailWidget(
                          title: AppLocalizations.of(context).football,
                          gameType: GameType.football,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: buildImage(AssetString.cardgame),
                    title: buildText(AppLocalizations.of(context).cardGame),
                    onTap: () {
                      // setState(() {
                      //   widget._controller.index = 2;
                      //   tabarIndexNotifier.value = 2;
                      // });
                      Navigator.pop(context);
                      goto(
                        context,
                        page: GamesByCategoryDetailWidget(
                          title: AppLocalizations.of(context).cardGame,
                          gameType: GameType.card,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: buildImage(AssetString.slot),
                    title: buildText(AppLocalizations.of(context).slotGame),
                    onTap: () {
                      // setState(() {
                      //   widget._controller.index = 3;
                      //   tabarIndexNotifier.value = 3;
                      // });
                      Navigator.pop(context);
                      goto(
                        context,
                        page: GamesByCategoryDetailWidget(
                          title: AppLocalizations.of(context).slotGame,
                          gameType: GameType.slot,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: buildImage(AssetString.fishing),
                    title: buildText(AppLocalizations.of(context).fishingGame),
                    onTap: () {
                      // setState(() {
                      //   widget._controller.index = 4;
                      //   tabarIndexNotifier.value = 4;
                      // });

                      Navigator.pop(context);
                      goto(
                        context,
                        page: GamesByCategoryDetailWidget(
                          title: AppLocalizations.of(context).fishingGame,
                          gameType: GameType.fishing,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: buildImage(AssetString.casino),
                    title: buildText(AppLocalizations.of(context).liveCasino),
                    onTap: () {
                      // setState(() {
                      //   widget._controller.index = 5;
                      //   tabarIndexNotifier.value = 5;
                      // });
                      Navigator.pop(context);
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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),),
              child: Column(children: [


                ListTile(
                  leading: buildIcon(Icons.group),
                  title: buildText(AppLocalizations.of(context).winnerList),
                  onTap: () {
                    // setState(() {
                    //   widget._controller.index = 1;
                    //   tabarIndexNotifier.value = 1;
                    // });
                    // Navigator.pop(context);
                    Navigator.pop(context);
                    goto(context, page: const WinnerListPage());
                  },
                ),

                ListTile(
                  leading: buildIcon(Icons.list_alt),
                  title: buildText("Crypto${AppLocalizations.of(context).twodSlips}"),
                  onTap: () {
                    // setState(() {
                    //   widget._controller.index = 1;
                    //   tabarIndexNotifier.value = 1;
                    // });
                    // Navigator.pop(context);
                    Navigator.pop(context);
                    goto(context, page: const CryptoTwoDBetSlipsPage());
                  },
                ),
                ListTile(
                  leading: buildIcon(Icons.list_alt),
                  title: buildText(AppLocalizations.of(context).twodSlips ),
                  onTap: () {
                    // setState(() {
                    //   widget._controller.index = 1;
                    //   tabarIndexNotifier.value = 1;
                    // });
                    // Navigator.pop(context);
                    Navigator.pop(context);
                    goto(context, page: const  TwoDBetSlipsPage());
                  },
                ),
                ListTile(
                  leading: buildIcon(Icons.list_alt),
                  title: buildText(AppLocalizations.of(context).threedSlips ),
                  onTap: () {
                    // setState(() {
                    //   widget._controller.index = 1;
                    //   tabarIndexNotifier.value = 1;
                    // });
                    // Navigator.pop(context);
                    Navigator.pop(context);
                    goto(context, page: const ThreeDBetSlipsPage());
                  },
                ),

                ListTile(
                  leading: buildIcon(Icons.games),
                  title: buildText(AppLocalizations.of(context).gameHistory ),
                  onTap: () {
                    // setState(() {
                    //   widget._controller.index = 1;
                    //   tabarIndexNotifier.value = 1;
                    // });
                    // Navigator.pop(context);
                    Navigator.pop(context);
                    goto(context, page: const GameReportPage());
                  },
                ),

              ],),
            ),
            Card(
              //elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                leading: buildIcon(Icons.language),
                title: buildText(AppLocalizations.of(context).language),
                onTap: () {
                  //Navigator.pop(context);
                  _showLanguageChange(context, ref);
                },
              ),
            ),
            ref.watch(authControllerProvider).maybeMap(
              authenticated: (value) {
                return Card(
                  //elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: buildIcon(Icons.logout),
                    title: buildText('Logout'),
                    onTap: () {
                     // Navigator.pop(context);
                      logoutDialog(context, ref);
                    },
                  ),
                );
              },
              orElse: () {
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }

  Text buildText(String text) => Text(
        text,
        style:
            TextStyle(fontWeight: FontWeight.bold, color: AppColor.accentColor),
      );

  Image buildImage(String assetString) => Image.asset(
        assetString,
        width: 24,
        height: 24,
        color: AppColor.accentColor,
      );

  Icon buildIcon(IconData iconData) => Icon(
        iconData,
        color: AppColor.accentColor,
        size: 27,
      );
}

void _showLanguageChange(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: const Text("Select Language"),
      children: chooseLanguageListWidget(context, ref),
    ),
  );
}
