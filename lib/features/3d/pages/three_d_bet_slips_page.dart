import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';
import '../../../core/widgets/custom_date_picker.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/date_time_helper.dart';
import '../providers/providers.dart';


class ThreeDBetSlipsPage extends ConsumerStatefulWidget {
  const ThreeDBetSlipsPage({super.key});
  @override
  ConsumerState<ThreeDBetSlipsPage> createState() => _CashInHistoryPageState();
}

class _CashInHistoryPageState extends ConsumerState<ThreeDBetSlipsPage> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(threeDBetSlipsController);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).threedSlips),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const KDatePickerWidget(),
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
                        AppLocalizations.of(context).noBetSlip.hardCoded,
                        style: AppTextStyle.yellowMedium,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: list.length,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    itemBuilder: (context, index) {
                      final history = list[index];
                      return ExpansionTile(
                        leading: CircleAvatar(
                          child: FittedBox(
                            child: Text(
                              "${history.totalBet}",
                            ),
                          ),
                        ),
                        title: Text("${history.totalAmount} MMK"),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "bet date:  ",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                Text(history.date.toString()),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "open date:  ",
                                  style: TextStyle(color: Colors.green),
                                ),
                                Text(
                                  formatDateForOnlyDay(
                                      history.betDate!, history.date3d!),
                                ),
                              ],
                            )
                          ],
                        ),
                        children: [
                          const Divider(),
                          Scrollbar(
                            controller: scrollController,
                            thumbVisibility: true,
                            thickness: 1,
                            child: SingleChildScrollView(
                              controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                headingTextStyle: AppTextStyle.yellowMedium
                                    .copyWith(color: Colors.blueGrey),
                                columns: const [
                                  DataColumn(
                                    label: Text("Bet Number"),
                                  ),
                                  DataColumn(
                                    label: Text("Bet Amount"),
                                  ),
                                  DataColumn(
                                    label: Text("Status"),
                                  ),
                                  DataColumn(
                                    label: Text("odd"),
                                  ),
                                  DataColumn(
                                    label: Text("Win Amount"),
                                  ),
                                ],
                                rows: List.generate(
                                  history.bettings3d!.length,
                                  (index) {
                                    final e = history.bettings3d![index];
                                    final win = e.win;
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Text("${e.betNumber}"),
                                        ),
                                        DataCell(
                                          Text("${e.amount}"),
                                        ),
                                        DataCell(
                                          Text(
                                            win == 0
                                                ? "Pending"
                                                : win == 1
                                                    ? "Win"
                                                    : "Lose",
                                            style: TextStyle(
                                              color: win == 0
                                                  ? Colors.yellow
                                                  : win == 1
                                                      ? Colors.green
                                                      : Colors.red,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text("${e.odd}"),
                                        ),
                                        DataCell(
                                          Text(
                                              "${win == 1 ? (double.parse(e.amount!) * e.odd!) : 0}"),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  );
                },
                error: (msg) => AppErrorWidget(
                  error: msg,
                  onRetry: () {
                    ref.refresh(threeDBetSlipsController);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
