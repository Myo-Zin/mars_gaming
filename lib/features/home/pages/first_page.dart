import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:store_checker/store_checker.dart';

import '../../../core/router/router.gr.dart';
import '../../../core/strings.dart';
import '../../profile/widgets/show_update_dialog.dart';
import '../services/home_api_service.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    _checkUpdate();
  }

  _goto() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        context.router.pushAndPopUntil(
          const NaviRoute(),
          predicate: (route) => false,
        );
      },
    );
  }

  _checkUpdate() async {
    final appUpdateData = await HomeApiService.checkAppUpdate();

    final appBuildNumber = await getBuildNumber();

    walletHideAccountId = appUpdateData?.walletHideAccountId;

    Source installationSource = await StoreChecker.getSource;

    final hasPlayStore =
        installationSource == Source.IS_INSTALLED_FROM_PLAY_STORE;
    final bool isUpdate = (appUpdateData?.versionCode ?? 0) > appBuildNumber;
    if (isUpdate && appUpdateData != null) {
      if (appUpdateData.forceUpdate == 0 && hasPlayStore) {
        _goto();
      } else {
        if (context.mounted) {
          showUpdateDialog(
            context,
            appUpdateData,
            goto: _goto,
          );
        }
      }
    } else {
      _goto();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          child: Image.asset(AssetString.logo),
        ),
      ),
    );
  }
}

int? walletHideAccountId;

Future<int> getBuildNumber() async {
  try {
    final info = await PackageInfo.fromPlatform();
    final appBuildNumber = int.parse(info.buildNumber);
    return appBuildNumber;
  } catch (e) {
    return 1;
  }
}
