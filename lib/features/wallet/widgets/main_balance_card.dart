import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/strings.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../profile/models/profile_response.dart';
import '../../profile/providers/providers.dart';
import 'balance_transfer_dialog.dart';



class MainBalanceCard extends ConsumerWidget {
  final ProfileData profile;
  const MainBalanceCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.watch(profileControllerProvider);
    return Column(
      children: [
        Stack(
          children: [
            Column(
              children: [
                _BalanceCard(
                  title: AppLocalizations.of(context).mainBalance,
                 // image: AssetString.dollor,
                  balance: '${profile.balance ?? 0}  MMK',
                ),
                const SizedBox(height: 10),
                _BalanceCard(
                  title: AppLocalizations.of(context).gameBalance,
                  //image: AssetString.gameController,
                  balance:
                      '${double.parse(profile.gameBalance ?? '0')}' '  MMK',
                ),
              ],
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: MaterialButton(
                    onPressed: () {
                      profileController.maybeMap(
                        data: (value) {
                          showBalanceTransferDialog(context, value.profileData);
                        },
                        orElse: () {},
                      );
                    },
                    elevation: 10,
                    color: AppColor.accentColor,
                    padding: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(CupertinoIcons.repeat),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        _BalanceCard(
          title: AppLocalizations.of(context).turnOver,
         // image: AssetString.turnover,
          balance: '${double.parse(profile.turnover ?? '0')}',
        ),
      ],
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({
    Key? key,
    required this.balance,
    required this.title,
  }) : super(key: key);

  final String title;
  final String balance;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: AppTheme.containerDecoration.copyWith(
        border: Border.all(
          color: AppColor.secondColor,
          width: 0.1,
        ),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: AppColor.greyTextColor),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    balance,
                    style: AppTextStyle.yellowTitle,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  // child: Image.asset(
                  //   image,
                  //   color: AppColor.greyTextColor,
                  // ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
