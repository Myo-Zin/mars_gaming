import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/custom_date_picker.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/route.dart';
import '../../profile/providers/providers.dart';
import '../models/game_report_detail_param.dart';
import '../providers/providers.dart';
import 'game_report_detail_page.dart';

class GameReportPage extends ConsumerStatefulWidget {
  const GameReportPage({super.key});
  @override
  ConsumerState<GameReportPage> createState() => _CashInHistoryPageState();
}

class _CashInHistoryPageState extends ConsumerState<GameReportPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gameReportController);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).gameHistory),
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
                        AppLocalizations.of(context).noGameHistory,
                        style: AppTextStyle.yellowMedium
                            .copyWith(color: Colors.white),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: list.length,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    itemBuilder: (context, index) {
                      final reports = list[index];
                      final isWin =
                          reports.totalbydate?.winloss?.contains("-") == false;
                      return ExpansionTile(
                        leading: CircleAvatar(
                          backgroundColor: isWin ? Colors.green : Colors.red,
                          child: FittedBox(
                            child: Text(
                              isWin ? "Win" : "Lose",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        title: Text(
                          "${reports.totalbydate?.profitloss}",
                          style: TextStyle(
                              color: isWin ? Colors.green : Colors.red),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            // ExpansionChildWidget(
                            //   label: AppLocalizations.of(context).date,
                            //   content: reports.date,
                            // ),
                            // ExpansionChildWidget(
                            //   label: "Bet Amount",
                            //   content: reports.totalbydate?.turnover,
                            // ),
                          ],
                        ),
                        children: [
                          const Divider(),
                          Row(
                            children: [
                              const Expanded(
                                  child: Text(
                                "Provider",
                                style: TextStyle(color: Colors.blueGrey),
                              )),
                              const Expanded(
                                  child: Text(
                                "Bet Amount",
                                style: TextStyle(color: Colors.blueGrey),
                              )),
                              Expanded(
                                  child: Text(
                                AppLocalizations.of(context).winloss,
                                style: const TextStyle(color: Colors.blueGrey),
                              )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final e = reports.providerData![index];

                              return GestureDetector(
                                onTap: () {
                                  final profile =
                                      ref.read(profileControllerProvider);
                                  profile.whenOrNull(
                                    data: (data) {
                                      final param = GameReportDetailParam(
                                        date: reports.date!,
                                        provider: e.pCode!,
                                        usercode: data.userCode!,
                                        token: data.token!,
                                      );
                                      goto(
                                        context,
                                        page:
                                            GameReportDetailPage(param: param),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      "${e.provider}",
                                      style: TextStyle(
                                        color: AppColor.accentColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    )),
                                    Expanded(child: Text("${e.totalTurnover}")),
                                    Expanded(
                                      child: Text(
                                        "${e.totalWinloss}",
                                        style: TextStyle(
                                          color: e.totalWinloss!.contains("-")
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: reports.providerData!.length,
                          ),
                        ],
                      );
                    },
                  );
                },
                error: (msg) => AppErrorWidget(
                  error: msg,
                  onRetry: () {
                    ref.invalidate(gameReportController);
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
