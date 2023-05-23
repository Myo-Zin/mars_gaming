import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/social_link_response.dart';
import '../repositories/home_repository.dart';

class SocialLinkNotifier extends StateNotifier<AsyncValue<SocialLinks>> {
  final HomeRepository homeRepository;

  SocialLinkNotifier(this.homeRepository) : super(const AsyncLoading()) {
    getSocialLinks();
  }

  Future<void> getSocialLinks() async {
    final result = await homeRepository.getSocialLinks();
    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.empty),
      (r) => AsyncData(r),
    );
  }
}
