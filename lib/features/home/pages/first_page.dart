
import 'package:flutter/material.dart';
import 'package:store_checker/store_checker.dart';

import '../../../core/strings.dart';
import '../../profile/widgets/show_update_dialog.dart';
import '../services/home_api_service.dart';
import '../widgets/bottom_nav_widget.dart';


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
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const NaviWidget()),
          (route) => false,
        );
      },
    );
  }

  _checkUpdate() async {
    final appUpdateData = await HomeApiService.checkAppUpdate();
    showWallet = appUpdateData?.showWallet == 1 ? true : false;
    Source installationSource = await StoreChecker.getSource;
    final hasPlayStore =
        installationSource == Source.IS_INSTALLED_FROM_PLAY_STORE;
    print("appUpdateData?.versionCode${appVersionCode}");
    final bool noUpdate = (appUpdateData?.versionCode ?? 0) <= appVersionCode;
    if (appUpdateData == null || noUpdate) {
      _goto();
    } else {
      //can skip
      if (appUpdateData.forceUpdate == 0 && hasPlayStore) {
        _goto();
      } else {
        if (mounted) {
          showUpdateDialog(
            context,
            appUpdateData,
            goto: _goto,
          );
        }
      }
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
bool showWallet = false;

//TODO please update this version number everytime you update to new version

const appVersionCode = 4;
