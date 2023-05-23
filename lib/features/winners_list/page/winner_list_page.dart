import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/app_color.dart';
import 'winner_2d_list_page.dart';
import 'winner_3d_page.dart';
import 'winner_crypto_page.dart';


class WinnerListPage extends StatelessWidget {
  const WinnerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom:  TabBar(
            //isScrollable: true,
            indicatorColor: AppColor.accentColor,
            tabs: [
              Tab(text: AppLocalizations.of(context).twoD),
              Tab(text: "Crypto ${AppLocalizations.of(context).twoD}"),
              Tab(text:  AppLocalizations.of(context).threeD),
            ],
          ),
          title:  Text(AppLocalizations.of(context).winnerList),
        ),
        body:  const TabBarView(
          children: [
           WinnerTwoDListPage(),
           WinnerCryptoListPage(),
           WinnerThreeDListPage()
          ],
        ),
      ),
    );
  }
}
