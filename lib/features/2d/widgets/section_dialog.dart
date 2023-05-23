import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/date_time_helper.dart';
import '../../../utils/route.dart';
import '../pages/two_d_betting_page.dart';
import '../providers/providers.dart';


showTwoDSectionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const Dialog(
        child: _TwoDSectionWidget(),
      );
    },
  );
}

class _TwoDSectionWidget extends ConsumerWidget {
  const _TwoDSectionWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(twoDSectionController);
    return state.when(
      data: (data) {
        if (data.isEmpty) {
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Notice".hardCoded,
                    style: AppTextStyle.yellowTitle,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "All section closed for today.\n Please Come back tomorrow."
                        .hardCoded,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK".hardCoded),
                  )
                ],
              ),
            ),
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                "Choose Section".hardCoded,
                style: AppTextStyle.yellowMedium,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final isEx = isExpired(closeTime: data[index].closeTime!);
                final sectionTime = formatTime(data[index].timeSection!);

                return ListTile(
                  onTap: () {
                    if (isEx) {
                      return;
                    }
                    Navigator.pop(context);
                    goto(context, page: TwoDBettingPage(section: sectionTime));
                  },
                  leading: Icon(
                    Icons.access_time,
                    color: AppColor.accentColor,
                  ),
                  title: Text(
                    "$sectionTime${isEx ? ' (Expired)' : ''}",
                    style: TextStyle(color: isEx ? Colors.red : null),
                  ),
                );
              },
            ),
          ],
        );
      },
      error: (error, stackTrace) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
                child: Text(
              error.toString(),
              textAlign: TextAlign.center,
            )),
          ),
        );
      },
      loading: () => const SizedBox(
        height: 100,
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
