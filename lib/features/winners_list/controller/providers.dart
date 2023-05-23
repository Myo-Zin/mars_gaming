import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/dio_provider.dart';
import '../model/winnner_response.dart';
import '../repository/winner_repository.dart';
import '../service/winner_service.dart';
import 'winner_controller.dart';

final winnerServiceProvider =
    Provider((ref) => WinnerService(ref.read(dioProvider)));

final winnerRepositoryProvider =
    Provider((ref) => WinnerRepository(ref.read(winnerServiceProvider)));

final winnerControllerProvider = StateNotifierProvider.family<WinnerNotifier,
    AsyncValue<List<Winner>>, String>(
  (ref, url) => WinnerNotifier(
    url,
    ref.read(winnerRepositoryProvider),
  ),
);
