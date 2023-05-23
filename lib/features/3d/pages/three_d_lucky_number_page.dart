import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/features/3d/pages/three_d_bet_slips_page.dart';
import 'package:mars_gaming/features/3d/pages/three_d_betting_page.dart';
import 'package:mars_gaming/features/3d/pages/three_d_lucky_number_history_page.dart';
import 'package:mars_gaming/utils/async_value_ui.dart';
import 'package:mars_gaming/utils/extension.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';

import '../../../utils/date_time_helper.dart';
import '../../../utils/route.dart';
import '../../auth/providers/providers.dart';
import '../../profile/widgets/login_dialog.dart';
import '../providers/providers.dart';

class ThreeDLuckyNumberPage extends ConsumerWidget {
  const ThreeDLuckyNumberPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final luckyNumListState = ref.watch(threeDDailyLuckyNumberController);
    final checkSectionState = ref.watch(threeDSectionController);
    ref.listen(
      threeDSectionController,
      (previous, next) => next.showSnackBarOnError(context),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lucky Number".hardCoded),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            luckyNumListState.when(
              data: (list) {
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      "Data unavailable!".hardCoded,
                      style: AppTextStyle.yellowMedium,
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    await ref
                        .read(threeDDailyLuckyNumberController.notifier)
                        .getLuckyNumbers();
                  },
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisExtent: 150,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.secondColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              list[index].luckynumber ?? "",
                              style: AppTextStyle.yellowTitle,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${list[index].date}-${DateTime.now().month}-${DateTime.now().year}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
              error: (error, stackTrace) => AppErrorWidget(
                error: error,
                onRetry: () {
                  ref
                      .read(threeDDailyLuckyNumberController.notifier)
                      .getLuckyNumbers();
                },
              ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final auth = ref.read(authControllerProvider);
                        auth.maybeMap(
                          authenticated: (value) {
                            goto(context, page: const ThreeDLuckyNumberHistoryPage());
                          },
                          unAuthenticated: (_) {
                            loginDialog(context);
                          },
                          orElse: () {},
                        );

                      },
                      child:
                      Text(AppLocalizations.of(context).history.hardCoded),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final auth = ref.read(authControllerProvider);
                        auth.maybeMap(
                          authenticated: (value) {
                            goto(context, page: const ThreeDBetSlipsPage());
                          },
                          unAuthenticated: (_) {
                            loginDialog(context);
                          },
                          orElse: () {},
                        );
                      },
                      child:
                          Text(AppLocalizations.of(context).betslip.hardCoded),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: checkSectionState.isLoading
                          ? () {}
                          : () {
                              final auth = ref.read(authControllerProvider);
                              auth.maybeMap(
                                authenticated: (value) async {
                                  ref
                                      .read(threeDSectionController.notifier)
                                      .getSection()
                                      .then((section) {
                                    if (section != null) {
                                      final isClosed = isThreeDClose(section);
                                      if (isClosed) {
                                        if (!checkSectionState.hasError) {
                                          context.showErrorSnackbar(
                                            "Section already closed!",
                                          );
                                        }
                                      } else {
                                        goto(context,
                                            page: ThreeDBettingPage(
                                              section: section,
                                            ));
                                      }
                                    } else {
                                      if (!checkSectionState.hasError) {
                                        context.showErrorSnackbar(
                                          "Section already closed!",
                                        );
                                      }
                                    }
                                  });
                                },
                                unAuthenticated: (_) {
                                  loginDialog(context);
                                },
                                orElse: () {},
                              );
                            },
                      child: checkSectionState.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : Text(AppLocalizations.of(context).bet.hardCoded),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
