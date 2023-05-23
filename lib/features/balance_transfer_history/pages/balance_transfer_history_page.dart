import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';

import '../../../core/widgets/custom_date_picker.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/date_time_helper.dart';
import '../providers/balance_transfer_history_controller.dart';
import '../providers/providers.dart';




class BalanceTransferHistoryPage extends ConsumerStatefulWidget {
  final String title;
  final BalanceTransferType type;
  const BalanceTransferHistoryPage({
    super.key,
    required this.type,
    required this.title,
  });

  @override
  ConsumerState<BalanceTransferHistoryPage> createState() =>
      _BalanceTransferHistoryPageState();
}

class _BalanceTransferHistoryPageState
    extends ConsumerState<BalanceTransferHistoryPage> {
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
    final state =
        ref.watch(balanceTransferHistoryControllerProvider(widget.type));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                        "No Transfer History with selected date!".hardCoded,
                        style: AppTextStyle.yellowMedium,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: list.length,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    itemBuilder: (context, index) {
                      final history = list[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                          title: Row(
                            children: [
                              const Text("Transfer Amount: "),
                              Text(
                                "${history.transferBalance}",
                                style: AppTextStyle.yellowMedium,
                              ),
                            ],
                          ),
                          subtitle: Column(
                            children: [
                              const Divider(),
                              Row(
                                children: [
                                  const Text(
                                    "game balance: ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    history.gameBalance.toString(),
                                    style: TextStyle(
                                      color: AppColor.accentColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    "main balance: ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    history.mainBalance.toString(),
                                    style: TextStyle(
                                      color: AppColor.accentColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    "DateTime: ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    formatDate(history.createdAt!),
                                    style: TextStyle(
                                      color: AppColor.accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (msg) => AppErrorWidget(
                  error: msg,
                  onRetry: () {
                    ref.refresh(
                        balanceTransferHistoryControllerProvider(widget.type));
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
