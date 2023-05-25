import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../is_cryptoTwod_avaliable.dart';
import '../models/crypto_two_d.dart';
import '../repositories/crypto_two_d_repository.dart';
import '../services/crypto_two_d_const.dart';

class CryptoTwoDNotifier extends StateNotifier<AsyncValue<List<CryptoTwoD>>> {
  CryptoTwoDNotifier(this.repository) : super(const AsyncLoading());
  final CryptoTwoDRepository repository;

  Future<void> getTwoDList(String section) async {
    final result = await repository.getCryptoTwoDList(section);
    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.empty),
      (r) => AsyncData(r),
    );
  }

  void select(int id) {
    state.whenData((list) {
      state = AsyncData([
        for (final td in list)
          if (td.id == id && isCryptoTwoDAvailable(td))
            td.copyWith(isSelected: !td.isSelected!)
          else
            td
      ]);
    });
  }

  void clearAll() {
    state.whenData((list) {
      state = AsyncData([for (final n in list) n.copyWith(isSelected: false)]);
    });
  }

  void reverse() {
    Set<String> list = {};
    List<CryptoTwoD> selectedNumber = state.asData?.value
            .where((e) => e.isSelected == true && e.block == false)
            .toList() ??
        [];

    for (final n in selectedNumber) {
      list.add(n.betNumber.toString());
      list.add(n.betNumber!.split("").reversed.join());
    }

    state = AsyncData([
      for (final s in (state.asData?.value ?? <CryptoTwoD>[]))
        if (list.contains(s.betNumber) && isCryptoTwoDAvailable(s))
          s.copyWith(isSelected: true)
        else
          s
    ]);
  }

  ///ကြီး
  void big() {
    state.whenData((list) {
      state = AsyncData([
        for (final td in list)
          if (td.id! >= 51 && isCryptoTwoDAvailable(td))
            td.copyWith(isSelected: true)
          else
            td
      ]);
    });
  }

  ///ငယ်
  void small() {
    state.whenData((list) {
      state = AsyncData([
        for (final td in list)
          if (td.id! <= 50 && isCryptoTwoDAvailable(td))
            td.copyWith(isSelected: true)
          else
            td
      ]);
    });
  }

  void _quickSelect(List<String> list) {
    state.whenData((twoDList) {
      state = AsyncData([
        for (final td in twoDList)
          if (list.contains(td.betNumber) && isCryptoTwoDAvailable(td))
            td.copyWith(isSelected: true)
          else
            td
      ]);
    });
  }

  ///စုံစုံ
  void evenEven() {
    _quickSelect(evenEvenList);
  }

  ///မမ
  void oddOdd() {
    _quickSelect(oddOddList);
  }

  ///မစုံ
  void oddEven() {
    _quickSelect(oddEvenList);
  }

  ///စုံမ
  void evenOdd() {
    _quickSelect(evenOddList);
  }

  ///မပူး
  void oddPair() {
    _quickSelect(oddPairList);
  }

  ///စုံပူး
  void evenPair() {
    _quickSelect(evenPairList);
  }

  ///စုံထိပ်
  void evenStart() {
    _quickSelect(evenStartList);
  }

  ///မထိပ်
  void oddStart() {
    _quickSelect(oddStartList);
  }

  ///စုံနောက်
  void evenEnd() {
    _quickSelect(evenEndList);
  }

  ///မနောက်
  void oddEnd() {
    _quickSelect(oddEndList);
  }

  ///------------------------------------------///
  ///0 ထိပ်စည်း
  void start0() {
    _quickSelect(start0List);
  }

  ///1 ထိပ်စည်း
  void start1() {
    _quickSelect(start1List);
  }

  ///2 ထိပ်စည်း
  void start2() {
    _quickSelect(start2List);
  }

  ///3 ထိပ်စည်း
  void start3() {
    _quickSelect(start3List);
  }

  ///4 ထိပ်စည်း
  void start4() {
    _quickSelect(start4List);
  }

  ///5 ထိပ်စည်း
  void start5() {
    _quickSelect(start5List);
  }

  ///6 ထိပ်စည်း
  void start6() {
    _quickSelect(start6List);
  }

  ///7 ထိပ်စည်း
  void start7() {
    _quickSelect(start7List);
  }

  ///8 ထိပ်စည်း
  void start8() {
    _quickSelect(start8List);
  }

  ///9 ထိပ်စည်း
  void start9() {
    _quickSelect(start9List);
  }

  ///------------------------------------------///

  ///0 တစ်လုံးပတ်
  void include0() {
    _quickSelect(include0List);
  }

  ///1 တစ်လုံးပတ်
  void include1() {
    _quickSelect(include1List);
  }

  ///2 တစ်လုံးပတ်
  void include2() {
    _quickSelect(include2List);
  }

  ///3 တစ်လုံးပတ်
  void include3() {
    _quickSelect(include3List);
  }

  ///4 တစ်လုံးပတ်
  void include4() {
    _quickSelect(include4List);
  }

  ///5 တစ်လုံးပတ်
  void include5() {
    _quickSelect(include5List);
  }

  ///6 တစ်လုံးပတ်
  void include6() {
    _quickSelect(include6List);
  }

  ///7 တစ်လုံးပတ်
  void include7() {
    _quickSelect(include7List);
  }

  ///8 တစ်လုံးပတ်
  void include8() {
    _quickSelect(include8List);
  }

  ///9 တစ်လုံးပတ်
  void include9() {
    _quickSelect(include9List);
  }

  ///------------------------------------------///

  ///0 နောက်ပိတ်
  void end0() {
    _quickSelect(end0List);
  }

  ///1 နောက်ပိတ်
  void end1() {
    _quickSelect(end1List);
  }

  ///2 နောက်ပိတ်
  void end2() {
    _quickSelect(end2List);
  }

  ///3 နောက်ပိတ်
  void end3() {
    _quickSelect(end3List);
  }

  ///4 နောက်ပိတ်
  void end4() {
    _quickSelect(end4List);
  }

  ///5 နောက်ပိတ်
  void end5() {
    _quickSelect(end5List);
  }

  ///6 နောက်ပိတ်
  void end6() {
    _quickSelect(end6List);
  }

  ///7 နောက်ပိတ်
  void end7() {
    _quickSelect(end7List);
  }

  ///8 နောက်ပိတ်
  void end8() {
    _quickSelect(end8List);
  }

  ///9 နောက်ပိတ်
  void end9() {
    _quickSelect(end9List);
  }

  ///------------------------------------------///

  /// 0 ဘရိတ်
  void break0() {
    _quickSelect(break0List);
  }

  /// 1 ဘရိတ်
  void break1() {
    _quickSelect(break1List);
  }

  /// 2 ဘရိတ်
  void break2() {
    _quickSelect(break2List);
  }

  /// 3 ဘရိတ်
  void break3() {
    _quickSelect(break3List);
  }

  /// 4 ဘရိတ်
  void break4() {
    _quickSelect(break4List);
  }

  /// 5 ဘရိတ်
  void break5() {
    _quickSelect(break5List);
  }

  /// 6 ဘရိတ်
  void break6() {
    _quickSelect(break6List);
  }

  /// 7 ဘရိတ်
  void break7() {
    _quickSelect(break7List);
  }

  /// 8 ဘရိတ်
  void break8() {
    _quickSelect(break8List);
  }

  /// 9 ဘရိတ်
  void break9() {
    _quickSelect(break9List);
  }

  ///------------------------------------------///

  ///နက္ခတ်
  void star() {
    _quickSelect(starList);
  }

  ///ပါဝါ
  void power() {
    _quickSelect(powerList);
  }

  ///ညီအစ်ကို
  void brother() {
    _quickSelect(brotherList);
  }
}
