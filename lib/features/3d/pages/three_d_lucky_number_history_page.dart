import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';

import '../../../core/widgets/custom_date_picker.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_theme.dart';
import '../providers/providers.dart';

class ThreeDLuckyNumberHistoryPage extends ConsumerStatefulWidget {
  const ThreeDLuckyNumberHistoryPage({super.key});

  @override
  ConsumerState<ThreeDLuckyNumberHistoryPage> createState() =>
      _CashInHistoryPageState();
}

class _CashInHistoryPageState
    extends ConsumerState<ThreeDLuckyNumberHistoryPage> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(threeDLuckyNumberHistoryController);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).history),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const KDatePickerWidget(),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            Expanded(
              child: state.when(
                empty: () => const Center(
                  child: Text("Select Date"),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                data: (list) {
                  if (list.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context).noHistory.hardCoded,
                        style: AppTextStyle.yellowMedium,
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: controller,
                      thickness: 1,
                      child: SingleChildScrollView(
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingTextStyle: AppTextStyle.yellowMedium
                              .copyWith(color: Colors.blueGrey),
                          columns: const [
                            DataColumn(
                              label: Text("Date"),
                            ),
                            DataColumn(
                              label: Text("Time"),
                            ),
                            DataColumn(
                              label: Text("Lucky Number"),
                            ),
                          ],
                          rows: List.generate(list.length, (index) {
                            final history = list[index];
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text("${history.createDate}"),
                                ),
                                DataCell(
                                  Text("${history.section}"),
                                ),
                                DataCell(
                                  Center(child: Text("${history.luckyNumber}")),
                                )
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  );
                },
                error: (msg) => AppErrorWidget(
                  error: msg,
                  onRetry: () {
                    ref.invalidate(threeDLuckyNumberHistoryController);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
