import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enum.dart';
import '../../games/widgets/games_by_category_widget.dart';
import '../widgets/banner_widget.dart';
import '../widgets/game_category_widget.dart';
import '../widgets/games_column.dart';
import '../widgets/persistance_tabbar.dart';
import '../widgets/play_text_widget.dart';
import 'nav_drawer_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //final locale = ref.watch(localProvider);
    return Scaffold(
      //drawer: DrawerPage(_controller),
      body: SafeArea(
        child: Scaffold(
          drawer: DrawerPage(_controller),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(
                // headerSliverBuilder: (context, value) {
                //return
                slivers: [
                  const SliverAppBar(
                      centerTitle: true,
                      pinned: false,
                      floating: false,
                      title: Text("Mars Gaming")
                      // title: SizedBox(
                      //   height: 80,
                      //   child: Image.asset(
                      //     AssetString.logo,
                      //     fit: BoxFit.contain,
                      //   ),
                      // ),
                      // actions: [
                      //   TextButton(
                      //       onPressed: () {
                      //         _showLanguageChange(context, ref);
                      //       },
                      //       child: Text(
                      //         L10n.getFlag(locale.languageCode),
                      //         style: const TextStyle(fontSize: 20),
                      //       ))
                      // ],
                      ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: const [
                          BannerWidget(),
                          SizedBox(height: 10),
                          PlayTextWidget(),
                          GameCategoryWidget(),
                          HomeGameMenu(),
                        ],
                      ),
                    ),
                  ),
                  // SliverPersistentHeader(
                  //   pinned: true,
                  //   floating: true,
                  //   delegate: MyTab(_controller),
                  // )
                ]

                // body: TabBarView(
                //   physics: const NeverScrollableScrollPhysics(),
                //   controller: _controller,
                //   children: const <Widget>[
                //     HomeGameMenu(),
                //     GamesByCategoryWidget(
                //       gameType: GameType.football,
                //     ),
                //     GamesByCategoryWidget(
                //       gameType: GameType.card,
                //     ),
                //     GamesByCategoryWidget(
                //       gameType: GameType.slot,
                //     ),
                //     GamesByCategoryWidget(
                //       gameType: GameType.fishing,
                //     ),
                //     GamesByCategoryWidget(
                //       gameType: GameType.casino,
                //     ),
                //   ],
                // ),
                ),
          ),
        ),
      ),
    );
  }
}

// void _showLanguageChange(BuildContext context, WidgetRef ref) {
//   showDialog(
//     context: context,
//     builder: (context) => SimpleDialog(
//         title: const Text("Select Language"),
//         children: chooseLanguageListWidget(context, ref)),
//   );
// }
