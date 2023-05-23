import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/route.dart';
import '../../auth/providers/providers.dart';
import '../../profile/widgets/login_dialog.dart';
import '../providers/providers.dart';
import '../widgets/custom_animated_text.dart';
import '../widgets/section_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'crypto_two_d_betslips_page.dart';
import 'crypto_two_d_lucky_num_history.dart';

class CryptoTwoDLuckyNumberPage extends ConsumerWidget {
  const CryptoTwoDLuckyNumberPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final luckyNumListState = ref.watch(cryptoTwoDDailyLuckyNumberController);
    final cryptoTwoDLiveState = ref.watch(cryptoTwoDLiveController);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lucky Number".hardCoded),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            cryptoTwoDLiveState.when(
              data: (live) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColor.secondColor,
                        radius: 100,
                        child: KAnimatedText(
                          live.number.toString(),
                          style: TextStyle(
                            fontSize: 30,
                            color: AppColor.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   live.
                            //       // == "--"
                            //       // ? currentDateTimeForThai2DLive()
                            //       // : dateFormatForThai2DLive(live.time!)
                            //   ,
                            //   style: const TextStyle(fontSize: 17),
                            // ),
                            // const SizedBox(height: 10),
                            Text(
                              "Buy",
                              style: TextStyle(color: AppColor.accentColor),
                            ),
                            SizedBox(
                              height: 25,
                              child: KAnimatedText(
                                live.buy.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Text(
                            //   "Value",
                            //   style: TextStyle(color: AppColor.accentColor),
                            // ),
                            // SizedBox(
                            //   height: 25,
                            //   child: KAnimatedText(
                            //     live.value!,
                            //     style: const TextStyle(fontSize: 16),
                            //   ),
                            // ),
                          ],
                        ),
                      ))
                    ],
                  ),
                );
              },
              error: (error, stackTrace) => AppErrorWidget(
                error: error,
                onRetry: () {
                  ref
                      .read(cryptoTwoDLiveController.notifier)
                      .getCryptoTwoDLive();
                },
              ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
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
                        .read(cryptoTwoDDailyLuckyNumberController.notifier)
                        .getDailyLuckyNumbers();
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
                              list[index].c2d!,
                              style: AppTextStyle.yellowTitle,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              list[index].time!,
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
                      .read(cryptoTwoDDailyLuckyNumberController.notifier)
                      .getDailyLuckyNumbers();
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
                            goto(context, page: const CryptoTwoDLuckyNumberHistoryPage());
                          },
                          unAuthenticated: (_) {
                            loginDialog(context);
                          },
                          orElse: () {},
                        );
                      },
                      child: Text(AppLocalizations.of(context).history.hardCoded),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final auth = ref.read(authControllerProvider);
                        auth.maybeMap(
                          authenticated: (value) {
                            goto(context, page: const CryptoTwoDBetSlipsPage());
                          },
                          unAuthenticated: (_) {
                            loginDialog(context);
                          },
                          orElse: () {},
                        );
                      },
                      child: Text(AppLocalizations.of(context).betslip.hardCoded),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final auth = ref.read(authControllerProvider);
                        auth.maybeMap(
                          authenticated: (value) {
                            showCryptoTwoDSectionDialog(context);
                          },
                          unAuthenticated: (_) {
                            loginDialog(context);
                          },
                          orElse: () {},
                        );
                      },
                      child: Text(AppLocalizations.of(context).bet.hardCoded),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
