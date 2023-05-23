import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';

import '../../../core/widgets/custom_date_picker.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_theme.dart';
import '../providers/providers.dart';
import '../widgets/expansion_child_widget.dart';
import '../widgets/status_circular_avator.dart';

class CashInHistoryPage extends ConsumerStatefulWidget {
  const CashInHistoryPage({super.key});

  @override
  ConsumerState<CashInHistoryPage> createState() => _CashInHistoryPageState();
}

class _CashInHistoryPageState extends ConsumerState<CashInHistoryPage> {
  late TextEditingController startDateTextController;
  late TextEditingController endDateTextController;

  @override
  void initState() {
    super.initState();
    startDateTextController = TextEditingController();
    endDateTextController = TextEditingController();
  }

  @override
  void dispose() {
    startDateTextController.dispose();
    endDateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cashInHistoryControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cash In History"),
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
                  child: Text("Select both date to see cash in history"),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                data: (list) {
                  if (list.isEmpty) {
                    return Center(
                      child: Text(
                        "No cash in history with selected date!".hardCoded,
                        style: AppTextStyle.yellowMedium
                            .copyWith(color: Colors.white),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: list.length,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    itemBuilder: (context, index) {
                      final history = list[index];
                      return ExpansionTile(
                        leading: StatusCircularAvator(status: history.status),
                        title: Text(history.amount.toString()),
                        subtitle: Text(history.date.toString()),
                        children: [
                          ExpansionChildWidget(
                            label: "Account Holder Name",
                            content: history.accountName,
                          ),
                          ExpansionChildWidget(
                            label: "Account Holder Phone",
                            content: history.userPhone,
                          ),
                          ExpansionChildWidget(
                            label: "Old Amount",
                            content: history.oldAmount.toString(),
                          ),
                          ExpansionChildWidget(
                            label: "Cash In Amount",
                            content: history.amount.toString(),
                          ),
                          ExpansionChildWidget(
                            label: "New Amount",
                            content: ((history.oldAmount ?? 0) +
                                    (history.amount ?? 0.0))
                                .toString(),
                          ),
                          ExpansionChildWidget(
                            label: "Status",
                            content: history.status,
                          ),
                          ExpansionChildWidget(
                            label: "Time",
                            content: history.time,
                          ),
                          ExpansionChildWidget(
                            label: "Date",
                            content: history.date,
                          ),
                        ],
                      );
                    },
                  );
                },
                error: (msg) => AppErrorWidget(
                  error: msg,
                  onRetry: () {
                    ref.refresh(cashInHistoryControllerProvider);
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
