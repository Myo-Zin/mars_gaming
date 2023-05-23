import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../2d/models/thai_two_d_live.dart';
import '../models/crypto_two_d_live.dart';
import '../repositories/crypto_two_d_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class CryptoTwoDLiveNotifier extends StateNotifier<AsyncValue<CryptoTwoDLive>> {
  CryptoTwoDLiveNotifier() : super(const AsyncLoading()) {
    getCryptoTwoDLive();
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        // getThaiTwoDLive();
      },
    );
  }

  Timer? timer;

  Future<void> getCryptoTwoDLive() async {
   // if (mounted) {
      try {
        // DatabaseReference databaseReference =
        //     FirebaseDatabase.instance.ref("number/data");
        DatabaseReference databaseReference = FirebaseDatabase.instanceFor(app: Firebase.app("secondApp")).ref("number/data");
        databaseReference.onValue.listen((event) {
          final snapshot = event.snapshot;
          if (snapshot.exists) {
            Map<String, dynamic> snapshotValue =
                Map<String, dynamic>.from(snapshot.value as Map);
            if (!mounted) return;
            state = AsyncData(CryptoTwoDLive.fromJson(snapshotValue));
          }
        });
      } catch (e) {
        state = AsyncError(e.toString(), StackTrace.empty);
      }
    //}
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
