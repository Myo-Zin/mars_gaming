import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../utils/app_color.dart';
import '../../../utils/route.dart';
import '../../../utils/url_constants.dart';
import '../model/payment_methods.dart';
import '../pages/cash_in_page.dart';
import '../pages/cash_out_page.dart';
import 'image_card.dart';
import 'mobile_top_up_widget.dart';
import 'payment_listile.dart';


class PaymentMethodsWidget extends ConsumerWidget {
  final PaymentMethods paymentMethods;
  final String url;
  final bool isCashIn;
  final int? promoid;

  const PaymentMethodsWidget({
    super.key,
    required this.paymentMethods,
    required this.url,
    required this.isCashIn,
    required this.promoid,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BoxDecoration containerDecorations = BoxDecoration(
        color: AppColor.secondColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.greyTextColor));

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: Text(
                'Payment',
                style: TextStyle(
                  color: AppColor.accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: containerDecorations,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: paymentMethods.pay!.length,
                itemBuilder: (context, index) {
                  final pay = paymentMethods.pay;
                  return PaymentListTile(
                    image: pay![index].logo,
                    title: pay[index].name,
                    callback: () {
                      if (isCashIn) {
                        goto(
                          context,
                          page: CashInPage(
                            title: pay[index].name,
                            image:  UrlConst.imagePrefix+pay[index].logo!,
                            paymentId: pay[index].id!,
                            accounts: pay[index].paymentAccountNumbers ?? [],
                            promoId: promoid,
                          ),
                        );
                      } else {
                        goto(context,
                            page: CashOutPage(
                              title: pay[index].name!,
                              image: pay[index].logo!,
                              paymentId: pay[index].id!,
                            ));
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: AppColor.greyTextColor,
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: containerDecorations,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 16),
                    child: Text(
                      'Supported Banking',
                      style: TextStyle(
                        color: AppColor.accentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColor.greyTextColor,
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      right: 16,
                      left: 16,
                    ),
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 15,
                        );
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: paymentMethods.banking!.length,
                      itemBuilder: (context, index) {
                        final banking = paymentMethods.banking;
                        return InkWell(
                          onTap: () {
                            if (isCashIn) {
                              goto(
                                context,
                                page: CashInPage(
                                  title: banking[index].name!,
                                  image: banking[index].logo!,
                                  paymentId: banking[index].id!,
                                  accounts:
                                      banking[index].paymentAccountNumbers ??
                                          [],
                                          promoId: promoid,
                                ),
                              );
                            } else {
                              goto(context,
                                  page: CashOutPage(
                                    title: banking[index].name!,
                                    image: banking[index].logo!,
                                    paymentId: banking[index].id!,
                                  ));
                            }
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.376,
                            child: Center(
                              child: ImageCard(
                                image: banking![index].logo,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            if(isCashIn) Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: containerDecorations,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 16),
                    child: Text(
                      'MobileToUp',
                      style: TextStyle(
                        color: AppColor.accentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColor.greyTextColor,
                  ),
                 if(isCashIn) Container(
                    height: 100,
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      right: 16,
                      left: 16,
                    ),
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 15,
                        );
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: paymentMethods.mobileTopUp!.length,
                      itemBuilder: (context, index) {
                        final mobileTopUp = paymentMethods.mobileTopUp;
                        return InkWell(
                          onTap: () {
                              goto(
                                context,
                                page: CashInPageMobileWidget(
                                  title: mobileTopUp[index].name!,
                                  image: mobileTopUp[index].logo!,
                                  paymentId: mobileTopUp[index].id!,
                                  fees:mobileTopUp[index].percentage.toString(),
                                  promoId: promoid,
                                ),
                              );
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.376,
                            child: Center(
                              child: ImageCard(
                                image: mobileTopUp![index].logo,
                              ),
                            ),
                          ),
                        );
                      },
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
