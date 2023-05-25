import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquee/marquee.dart';

import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_color.dart';
import '../providers/providers.dart';

class PlayTextWidget extends ConsumerWidget {
  const PlayTextWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playTextController = ref.watch(playTextControllerProvider);
    return playTextController.when(
      data: (list) {
        final textList = list.takeWhile((data) => data.text != null).toList();
        if (textList.isEmpty) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            //color: Colors.red,
            height: 40,
            child: Marquee(
              text: textList[0].text!,
              style: TextStyle(fontSize: 14, color: AppColor.accentColor),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              blankSpace: 20.0,
              velocity: 100.0,
              pauseAfterRound: const Duration(seconds: 2),
              startPadding: 10.0,
              accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: const Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
        );
      },
      error: (error, stackTrace) => Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: AppColor.secondColor,
        ),
        child: AppErrorWidget(
          error: error,
          onRetry: () {
            ref.invalidate(playTextControllerProvider);
          },
        ),
      ),
      loading: () => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: AppColor.secondColor,
        ),
      ),
    );
  }
}
