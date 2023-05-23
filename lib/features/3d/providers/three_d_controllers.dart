import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../2d/services/two_d_const.dart';
import '../is_threed_avaliable.dart';
import '../models/three_d.dart';
import '../repositories/three_d_repository.dart';

class ThreeDNotifier extends StateNotifier<AsyncValue<List<ThreeD>>> {
  final ThreeDRepository repository;

  ThreeDNotifier(this.repository) : super(const AsyncLoading()) {
    getThreeDList();
  }

  Future<void> getThreeDList() async {
    final result = await repository.getThreeDList();
    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.empty),
      (r) => AsyncData(r),
    );
  }

  void select(int id) {
    state.whenData((list) {
      state = AsyncData([
        for (final td in list)
          if (td.id == id && isThreeDAvalible(td))
            td.copyWith(isSelected: !td.isSelected!)
          else
            td
      ]);
    });
  }

  void round() {
    Set<String> list = {};
    List<ThreeD> selectedNumber = state.asData?.value
            .where((e) => e.isSelected == true && e.block == "no")
            .toList() ??
        [];

    for (final n in selectedNumber) {
      list.add(n.betNumber.toString());
      final splitList = n.betNumber!.split("");
      final roundNumber1 = splitList[0] + splitList[2] + splitList[1];
      final roundNumber2 = splitList[1] + splitList[0] + splitList[2];
      final roundNumber3 = splitList[1] + splitList[2] + splitList[0];
      final roundNumber4 = splitList[2] + splitList[0] + splitList[1];
      final roundNumber5 = splitList[2] + splitList[1] + splitList[0];
      list.add(roundNumber1);
      list.add(roundNumber2);
      list.add(roundNumber3);
      list.add(roundNumber4);
      list.add(roundNumber5);
    }

    state = AsyncData([
      for (final s in (state.asData?.value ?? []))
        if (list.contains(s.betNumber) && isThreeDAvalible(s))
          s.copyWith(isSelected: true)
        else
          s
    ]);
  }

  void clearAll() {
    state.whenData((list) {
      state = AsyncData([for (final n in list) n.copyWith(isSelected: false)]);
    });
  }

  void _quickSelect(List<String> list) {
    state.whenData((twoDList) {
      state = AsyncData([
        for (final td in twoDList)
          if (list.contains(td.betNumber) && isThreeDAvalible(td))
            td.copyWith(isSelected: true)
          else
            td
      ]);
    });
  }

  void pairEven() {
    _quickSelect(evenPairList);
  }

  void pairOdd() {
    _quickSelect(oddPairList);
  }

  void manualInput(List<String> list) {
    _quickSelect(list);
  }
}
