import 'package:flutter_riverpod/flutter_riverpod.dart';

class NaviIndexController extends StateNotifier<int> {
  NaviIndexController() : super(0);

  changeIndex(int value) {
    state = value;
  }
}
