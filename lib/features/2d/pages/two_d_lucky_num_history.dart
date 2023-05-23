import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';


import '../../../core/widgets/custom_date_picker.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_theme.dart';
import '../providers/providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TwoDLuckyNumberHistoryPage extends ConsumerStatefulWidget {
  const TwoDLuckyNumberHistoryPage({super.key});

  @override
  ConsumerState<TwoDLuckyNumberHistoryPage> createState() =>
      _CashInHistoryPageState();
}

class _CashInHistoryPageState
    extends ConsumerState<TwoDLuckyNumberHistoryPage> {
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
    final state = ref.watch(twoDLuckyNumberHistoryController);
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
                  //return
                  // ListView.builder(
                  // itemCount: list.length,
                  // padding: const EdgeInsets.symmetric(vertical: 15),
                  // itemBuilder: (context, index) {
                  //   final history = list[index];
                  return Scrollbar(
                    thumbVisibility: true,
                    thickness: 1,
                    child: SingleChildScrollView(
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
                  );
                  //   },
                  // )
                },
                error: (msg) => AppErrorWidget(
                  error: msg,
                  onRetry: () {
                    ref.refresh(twoDLuckyNumberHistoryController);
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
