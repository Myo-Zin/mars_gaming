import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../features/profile/providers/providers.dart';
import '../../utils/date_time_helper.dart';
import 'date_state.dart';

final dateController =
    StateNotifierProvider.autoDispose<DateNotifier, DateState>((ref) {
  return DateNotifier(ref);
});

class DateNotifier extends StateNotifier<DateState> {
  final Ref ref;

  DateNotifier(this.ref)
      : super(
          DateState(
            startDate: today,
            endDate: today,
            title: "Today",
            type: "2D",
          ),
        ) {

    final profileState = ref.watch(profileControllerProvider);
    profileState.maybeMap(
      data: (value) {
        state = state.copyWith(
          userId: value.profileData.id,
          token: value.profileData.token,
        );
      },
      orElse: () {},
    );
  }

  changeDateState({
    required String startDate,
    required String endDate,
    required String title,
  }) {
    state = state.copyWith(
      startDate: startDate,
      endDate: endDate,
      title: title,
    );
  }

  changeDateAndGameType({
    required String type,

  }){
    state = state.copyWith(
      startDate: state.startDate,
      endDate: state.endDate,
      type: type,
    );
  }
}
