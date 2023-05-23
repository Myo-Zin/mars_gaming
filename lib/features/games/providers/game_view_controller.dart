import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../profile/providers/providers.dart';
import '../repositories/games_repository.dart';
import '../widgets/game_view_loading_dialog.dart';
//TODO uncomment this code for web
// import 'dart:html' as html;

class KInAppBrowser extends InAppBrowser {
  final Ref ref;
  KInAppBrowser(this.ref);
  @override
  void onExit() {
    ref.read(profileControllerProvider.notifier).refreshProfile();
    super.onExit();
  }
}

class GameViewNotifier extends StateNotifier<AsyncValue<String?>> {
  GameViewNotifier(this.repository, this.ref) : super(const AsyncData(null));
  final GameRepository repository;
  final Ref ref;

  Future<void> getGameViewUrl({
    required String token,
    required int userId,
    required String gameCode,
    required BuildContext context,
  }) async {
    showGameViewLoadingDialog(context);
    final result = await repository.getGameViewUrl(
      token: token,
      userId: userId,
      gameCode: gameCode,
    );

    result.fold(
      (l) {
        state = AsyncError(l.message, StackTrace.empty);
        if (ModalRoute.of(context)?.isCurrent != true) {
          Navigator.pop(context);
        }

        return null;
      },
      (r) {
        state = AsyncData(r);
        if (ModalRoute.of(context)?.isCurrent != true) {
          Navigator.pop(context);
        }
        if (kIsWeb) {
          //TODO uncomment this code for web
          // html.window.open(r, "_self");
        }else{
          KInAppBrowser(ref).openUrlRequest(
            urlRequest: URLRequest(url: Uri.parse(r)),
            options: InAppBrowserClassOptions(
              crossPlatform: InAppBrowserOptions(hideUrlBar: false),
              inAppWebViewGroupOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(javaScriptEnabled: true),
              ),
            ),
          );
         
        }
        return r;
      },
    );
  }
}
