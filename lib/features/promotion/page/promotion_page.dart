import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';
import 'package:readmore/readmore.dart';
import '../../../core/widgets/custom_network_image.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_color.dart';
import '../../../utils/route.dart';
import '../../../utils/url_constants.dart';
import '../../auth/pages/login_page.dart';
import '../../auth/providers/providers.dart';
import '../../cash_in_out/pages/payment_methods_page.dart';
import '../../profile/providers/providers.dart';
import '../provider/provider.dart';

class PromotionPage extends ConsumerStatefulWidget {
  const PromotionPage({Key? key}) : super(key: key);

  @override
  ConsumerState<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends ConsumerState<PromotionPage> {
  @override
  Widget build(BuildContext context) {
    final promotionState = ref.watch(promotionController);
    final auth = ref.watch(authControllerProvider);
    return auth.maybeMap(authenticated: (value) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Promotions',
              style: TextStyle(
                color: AppColor.accentColor,
              ),
            ),
            shadowColor: Colors.transparent,
          ),
          body: promotionState.when(
            data: (promotionList) {
              return RefreshIndicator(
                onRefresh: () async {
                  ref.refresh(promotionController);
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ListView.builder(
                    itemCount: promotionList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final promotionItem = promotionList[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${promotionItem.title}',
                                style: TextStyle(
                                  color: AppColor.accentColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                              ),
                              Text(
                                  '${promotionItem.percent}% Cash Back,  ${promotionItem.turnover}odds'),
                              if (promotionItem.lvl == 2)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.accentColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'level ${promotionItem.lvl} required',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: KNetworkImage(
                                    url: promotionItem.image.toString(),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              ReadMoreText(
                                newLineSplitter(promotionItem.rule ?? ""),
                                trimLines: 2,
                                //colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                textAlign: TextAlign.justify,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                moreStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.accentColor),
                                lessStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.accentColor),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.grey // color
                                          ),
                                      // border radius
                                      borderRadius: BorderRadius.circular(10)),
                                  minimumSize: const Size.fromHeight(
                                      40), // fromHeight use double.infinity as width and 40 is the height
                                ),
                                onPressed: () {
                                  final profileState =
                                      ref.read(profileControllerProvider);
                                  profileState.maybeWhen(
                                    data: (data) {
                                      final turnover =
                                          double.parse(data.turnover ?? '0');
                                      final gameBalance =
                                          double.parse(data.gameBalance ?? '0');
                                      if (turnover > 0) {
                                        context.showErrorSnackbar(
                                          "You need to have turnover 0!",
                                        );
                                        return;
                                      }
                                      if (gameBalance > 500) {
                                        context.showErrorSnackbar(
                                          "Game balance must not be greater than 500!",
                                        );
                                        return;
                                      }

                                      final myLevel =
                                          data.lvl2 == null ? 0 : data.lvl2!;

                                      if (promotionItem.lvl == 2 &&
                                          myLevel == 0) {
                                        context.showErrorSnackbar(
                                          "You need to update to level2!",
                                        );
                                      } else {
                                        goto(
                                          context,
                                          page: PaymentMethodsPage(
                                            url:
                                                UrlConst.cashInPaymentMethodUrl,
                                            title: "Cash In",
                                            isCashIn: true,
                                            promoId: promotionItem.id!,
                                          ),
                                        );
                                      }
                                    },
                                    orElse: () {},
                                  );
                                },
                                child: const Text("Apply"),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            error: (error, s) => AppErrorWidget(
              error: error,
              onRetry: () {
                ref.refresh(promotionController);
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          ));
    }, orElse: () {
      return const LoginPage();
    });
  }

  String newLineSplitter(String text) => text.replaceAll("\n", "");
}
