import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/url_constants.dart';
import '../controller/providers.dart';

class WinnerCryptoListPage extends ConsumerStatefulWidget {
  const WinnerCryptoListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<WinnerCryptoListPage> createState() =>
      _WinnerCryptoListPageState();
}

class _WinnerCryptoListPageState extends ConsumerState<WinnerCryptoListPage> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final winnerSate =
        ref.watch(winnerControllerProvider(UrlConst.cryptoTwoDWinnerListUrl));
    return winnerSate.when(
      data: (list) {
        return list.isEmpty
            ? const Center(child: Text("No Data"))
            : SingleChildScrollView(
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
                          label: Text("No"),
                        ),
                        DataColumn(
                          label: Text("Phone"),
                        ),
                        DataColumn(
                          label: Text("Win Amount"),
                        ),
                        DataColumn(
                          label: Text("Bet Amount"),
                        ),
                      ],
                      rows: List.generate(list.length, (index) {
                        final winner = list[index];
                        return DataRow(
                          cells: [
                            DataCell(
                              Text("${index + 1}"),
                            ),
                            DataCell(
                              Text("${winner.phone}"),
                            ),
                            DataCell(
                              Center(child: Text("${winner.winAmount}")),
                            ),
                            DataCell(
                              Center(child: Text("${winner.betAmount}")),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              );
        ;
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (msg, stack) => AppErrorWidget(
        error: msg,
        onRetry: () {
          ref.refresh(
              winnerControllerProvider(UrlConst.cryptoTwoDWinnerListUrl));
        },
      ),
    );
  }
}
