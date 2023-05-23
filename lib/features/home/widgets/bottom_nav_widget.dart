import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/notification/notification_service.dart';
import '../../../utils/app_color.dart';
import '../../auth/providers/providers.dart';
import '../../profile/pages/profile_page.dart';
import '../../promotion/page/promotion_page.dart';
import '../../wallet/pages/wallet_page.dart';
import '../pages/contact_page.dart';
import '../pages/first_page.dart';
import '../pages/home_page.dart';
import '../providers/nav_controller.dart';

class NaviWidget extends ConsumerStatefulWidget {
  const NaviWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NaviWidgetState();
}

class _NaviWidgetState extends ConsumerState<NaviWidget> {
  final List<Widget> _body = [
    const HomePage(),
    const PromotionPage(),
    if(showWallet) const Scaffold(
      body: WalletPage(),
    ),
    const ContactPage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    // FirebaseMessaging.onMessage.listen(showFlutterNotification);
    _onMessage();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(authControllerProvider.notifier).getAuth();
    });
  }


  _onMessage() async {
    if (await FirebaseMessaging.instance.isSupported()) {
      FirebaseMessaging.onMessage
          .listen(kIsWeb ? _showNotificationOnWeb : showFlutterNotification);
    }
  }

  _showNotificationOnWeb(RemoteMessage message) {}

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(naviIndexControllerProvider);
    return WillPopScope(
      onWillPop: () async {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
          return false;
        } else {
          bool exit = false;
          await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text("Exit"),
                content: const Text("Do you want to exit app?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      exit = true;
                      Navigator.of(ctx, rootNavigator: true).pop();
                    },
                    child: const Text("Ok"),
                  ),
                ],
              );
            },
          );
          return exit;
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: _body,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColor.accentColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (value) {
            ref.read(naviIndexControllerProvider.notifier).changeIndex(value);
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.home),
              label: AppLocalizations.of(context).home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.speaker_fill),
              label: AppLocalizations.of(context).promotion,
            ),
            if(showWallet) BottomNavigationBarItem(
              icon: const Icon(Icons.shop),
              label: AppLocalizations.of(context).wallet,
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.phone_circle),
              label: AppLocalizations.of(context).contact,
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.profile_circled),
              label: AppLocalizations.of(context).profile,
            ),
          ],
        ),
      ),
    );
  }
}
