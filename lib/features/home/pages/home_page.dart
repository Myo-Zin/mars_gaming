import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/banner_widget.dart';
import '../widgets/game_category_widget.dart';
import '../widgets/games_column.dart';
import '../widgets/play_text_widget.dart';
import 'nav_drawer_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          drawer: const DrawerPage(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
