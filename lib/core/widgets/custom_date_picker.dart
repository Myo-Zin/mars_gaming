import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../utils/date_time_helper.dart';

import '../../features/cash_in_out_history/widgets/date_picker_textfield.dart';
import '../../utils/app_color.dart';
import '../providers/date_controller.dart';
import '../providers/date_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class KDatePickerWidget extends ConsumerWidget {
  const KDatePickerWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final ds = ref.watch(dateController);
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          DatePickerTextField(
            date: ds.startDate!,
          ),
          const Icon(Icons.arrow_forward),
          DatePickerTextField(
            date: ds.endDate!,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Material(
                color: Colors.transparent,
                child: PopupMenuButton<DateState>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  itemBuilder: ((context) {
                    return dateList.map((map) {
                      return PopupMenuItem<DateState>(
                        value: map,
                        child: Text(map.title!),
                      );
                    }).toList();
                  }),
                  onSelected: (map) async {
                    if (map.title == "Period") {
                      DateTimeRange? pickedRange;
                      pickedRange = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2021, 1, 1),
                        lastDate: DateTime.now(),
                      );
                      if (pickedRange != null) {
                        final to = formatDateForRange(pickedRange.end);
                        final from = formatDateForRange(pickedRange.start);
                        ref.read(dateController.notifier).changeDateState(
                              startDate: from,
                              endDate: to,
                              title: "Period",
                            );
                      }
                    } else {
                      ref.read(dateController.notifier).changeDateState(
                            startDate: map.startDate!,
                            endDate: map.endDate!,
                            title: map.title!,
                          );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.accentColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:  Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          AppLocalizations.of(context).select,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
