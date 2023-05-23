import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/dio_provider.dart';
import '../models/banner_reponse.dart';
import '../models/play_text_response.dart';
import '../models/social_link_response.dart';
import '../repositories/home_repository.dart';
import '../services/home_api_service.dart';
import 'banner_controller.dart';
import 'play_text_controller.dart';
import 'social_link_controller.dart';

final homeApiServiceProvider =
    Provider((ref) => HomeApiService(ref.read(dioProvider)));

final homeRepositoryProvider =
    Provider((ref) => HomeRepository(ref.read(homeApiServiceProvider)));

final bannerControllerProvider =
    StateNotifierProvider<BannerNotifier, AsyncValue<List<BannerProduct>>>(
        (ref) => BannerNotifier(ref.read(homeRepositoryProvider)));

final playTextControllerProvider =
StateNotifierProvider<PlayTextNotifier, AsyncValue<List<PlayText>>>(
        (ref) => PlayTextNotifier(ref.read(homeRepositoryProvider)));

final socialLinkControllerProvider =
StateNotifierProvider<SocialLinkNotifier, AsyncValue<SocialLinks>>(
        (ref) => SocialLinkNotifier(ref.read(homeRepositoryProvider)));
