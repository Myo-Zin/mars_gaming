import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/l10n.dart';
import '../../../l10n/local_provider.dart';
import '../../../l10n/util.dart';
import '../../../utils/app_color.dart';
import '../../../utils/route.dart';
import '../../2d/pages/two_d_betslips_page.dart';
import '../../3d/pages/three_d_bet_slips_page.dart';
import '../../crypto2d/pages/crypto_two_d_betslips_page.dart';
import '../../games/pages/game_report_page.dart';
import '../../referral/pages/referral_history_page.dart';
import '../models/profile_response.dart';
import '../pages/update_profile_page.dart';
import 'logout_dialog.dart';
import 'profile_image_widget.dart';

class ProfileWidget extends ConsumerWidget {
  final ProfileData profile;

  const ProfileWidget({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final local = ref.watch(localProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: ProfileImageWidget(profile: profile),
            ),
            Card(
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        _buildRow(AppLocalizations.of(context).name,
                            profile.name.toString()),
                        const SizedBox(
                          height: 18,
                        ),
                        _buildRow(AppLocalizations.of(context).phone,
                            profile.phone.toString()),
                        const SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                    Positioned(
                      right: 1,
                      child: InkWell(
                        onTap: () {
                          goto(context, page: UpdateProfilePage(profile));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: AppColor.accentColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                AppLocalizations.of(context).edit,
                                style: const TextStyle(
                                  color: AppColor.textColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildCard("Crypto${AppLocalizations.of(context).twodSlips}",
                () => {goto(context, page: const CryptoTwoDBetSlipsPage())}),
            _buildCard(AppLocalizations.of(context).twodSlips,
                () => {goto(context, page: const TwoDBetSlipsPage())}),
            _buildCard(AppLocalizations.of(context).threedSlips,
                () => {goto(context, page: const ThreeDBetSlipsPage())}),
            _buildCard(AppLocalizations.of(context).gameHistory,
                () => {goto(context, page: const GameReportPage())}),
            _buildCard1(
                AppLocalizations.of(context).referralHistory,
                "${AppLocalizations.of(context).friend} : ${profile.referCount != null ? profile.referCount.toString() : "0"}",
                () => {goto(context, page: ReferralPage(profile))}),
            _buildCard2(AppLocalizations.of(context).referralCode,
                "${profile.referral}", () {
              Clipboard.setData(ClipboardData(text: profile.referral))
                  .then((_) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Copied to clipboard ${profile.referral}")));
              });
            }),
            _buildCard3(
                AppLocalizations.of(context).language,
                L10n.getLanguage(local.languageCode),
                () => {showLanguageDialog(context, ref)})
            // Container(
            //   decoration: AppTheme.containerDecoration,
            //   child: ListTileRow(
            //     icon: Icons.language,
            //     title: AppLocalizations.of(context).language,
            //     //subtitle: L10n.getLanguage(local.languageCode),
            //     callback: () {
            //       //showLanguageDialog(context,ref);
            //     },
            //   ),
            // ),
            // const SizedBox(height: 4),
            ,
            InkWell(
              onTap: () {
                logoutDialog(context, ref);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      AppLocalizations.of(context).logout,
                      style: TextStyle(color: AppColor.accentColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String message) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: TextStyle(color: AppColor.accentColor),
          )),
          Expanded(child: Text(message))
        ],
      ),
    );
  }

  void showLanguageDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17.0),
      ),
      backgroundColor: AppColor.secondColor,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: chooseLanguageListWidget(context, ref)),
        );
      },
    );
  }

  Widget _buildCard(String title, Function() onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                title,
                style: TextStyle(color: AppColor.accentColor),
              )),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColor.accentColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard1(String title, String message, Function() onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                title,
                style: TextStyle(color: AppColor.accentColor),
              )),
              Text(message),
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColor.accentColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard2(String title, String message, Function() onPressed) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Expanded(
                child: Text(
              title,
              style: TextStyle(color: AppColor.accentColor),
            )),
            Text(message),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: onPressed,
              child: const Icon(
                Icons.copy,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCard3(String title, String message, Function() onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                title,
                style: TextStyle(color: AppColor.accentColor),
              )),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}
