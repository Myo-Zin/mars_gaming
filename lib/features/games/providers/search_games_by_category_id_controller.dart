import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../models/game_response.dart';
import '../models/games_by_id_param.dart';
import 'providers.dart';

class SearchGamesByCategoryIdNotifier extends StateNotifier<List<Game>> {
  SearchGamesByCategoryIdNotifier(this.ref, this.param, this.games)
      : super(games) {
    addState();
    ref.read(searchTextEditingControllerProvider(param.gameType)).addListener(
      () {
        addState();
      },
    );
  }
  final Ref ref;
  final GameByCategoryIdParam param;
  final List<Game> games;

  addState() {
    final searchText =
        ref.read(searchTextEditingControllerProvider(param.gameType));
    if (searchText.text.isEmpty || searchText.text == "") {
      if (mounted) {
        state = games;
      }
    }
    if (mounted) {
      state = games.where(
        (e) {
          return e.name!.toLowerCase().contains(searchText.text);
        },
      ).toList();
    }
  }
}
