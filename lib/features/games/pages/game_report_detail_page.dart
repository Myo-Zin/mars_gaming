import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_color.dart';
import '../models/game_report_detail_param.dart';
import '../providers/providers.dart';

class GameReportDetailPage extends ConsumerWidget {
  const GameReportDetailPage({super.key, required this.param});
  final GameReportDetailParam param;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameReportDetailController(param));
    return Scaffold(
      appBar: AppBar(
        title: Text(param.date),
        centerTitle: true,
      ),
      body: state.when(
        data: (list) {
          return Column(
            children: [
              const _HeaderRow(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(gameReportDetailController(param));
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shrinkWrap: true,
                    itemCount: list.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 20,
                    ),
                    itemBuilder: (context, index) {
                      final detail = list[index];
                      return Row(
                        children: [
                          Expanded(
                            child:
                                Center(child: Text(detail.gametype.toString())),
                          ),
                          Expanded(
                            child:
                                Center(child: Text(detail.turnover.toString())),
                          ),
                          Expanded(
                            child: Center(
                                child: Text(
                              detail.winloss.toString(),
                              style: TextStyle(
                                color: detail.winloss!.contains('-')
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            )),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
        error: (error, stackTrace) => Center(
          child: AppErrorWidget(
            error: error,
            onRetry: () {
              ref.invalidate(gameReportDetailController(param));
            },
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.accentColor,
      height: 40,
      child: Row(
        children: const [
          Expanded(
            child: Center(
              child: Text(
                "GameType",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Bet Amount",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Win/Loss",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
