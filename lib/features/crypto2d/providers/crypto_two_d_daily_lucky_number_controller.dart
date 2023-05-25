import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/crypto_two_d_lucky_number.dart';
import '../repositories/crypto_two_d_repository.dart';

class CryptoTwoDDailyLuckyNumberNotifier
    extends StateNotifier<AsyncValue<List<CryptoTwoDLuckyNumber>>> {
  CryptoTwoDDailyLuckyNumberNotifier(this.repository)
      : super(const AsyncLoading()) {
    getDailyLuckyNumbers();
  }

  final CryptoTwoDRepository repository;

  Future<void> getDailyLuckyNumbers() async {
    //
    // final result = await repository.getCryptoTwoDLuckyNumberDailyList();
    // state = result.fold(
    //   (l) => AsyncError(l.message, StackTrace.empty),
    //   (r) => AsyncData(r),
    // );
    if (mounted) {
      try {
        // DatabaseReference databaseReference =
        //     FirebaseDatabase.instance.ref("list/data");
        DatabaseReference databaseReference =
            FirebaseDatabase.instanceFor(app: Firebase.app("secondApp"))
                .ref("list/data");
        DatabaseEvent event = await databaseReference.once();
        final snapshot = event.snapshot;
        if (snapshot.exists) {
          var listData = snapshot.value as List;
          List<CryptoTwoDLuckyNumber> list = List<CryptoTwoDLuckyNumber>.from(
              listData.map((e) => CryptoTwoDLuckyNumber.fromJson(e)));
          state = AsyncData(list);
        }
      } catch (e) {
        state = AsyncError(e.toString(), StackTrace.empty);
      }
    }
  }
}
