import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/async_value_ui.dart';
import 'package:mars_gaming/utils/extension.dart';

import '../../../core/providers/date_controller.dart';
import '../../../core/widgets/custom_date_picker.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/date_time_helper.dart';
import '../../profile/models/profile_response.dart';
import '../providers/providers.dart';

class ReferralPage extends ConsumerStatefulWidget {
  const ReferralPage(this.profileData, {super.key});

  final ProfileData profileData;

  @override
  ConsumerState<ReferralPage> createState() => _ReferralHistoryPageState();
}

class _ReferralHistoryPageState extends ConsumerState<ReferralPage> {
  var items = ['2D', '3D', 'Crypto 2D'];
  String dropDownValue = '2D';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(referralController);
    final claimState = ref.watch(claimReferralController);
    ref.listen<AsyncValue>(
      claimReferralController,
      (_, state) => state.showSnackBarOnError(context),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).referralHistory),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Text(AppLocalizations.of(context).gameRefAmount)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("${widget.profileData.gameReferAmt}MMK"),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: claimState.isLoading
                        ? () {}
                        : () async {
                            // double claimAmt = double.parse(
                            //     widget.profileData.gameReferAmt ??
                            //         0.0.toString());
                            // if(claimAmt >0){
                            //   print("can calim");
                            // }else{
                            //   print("cannot calim");
                            // }
                            final isSuccess = await ref
                                .read(claimReferralController.notifier)
                                .claimReferAmount(
                                    widget.profileData.token ?? "");
                            if (isSuccess) {
                              if (mounted) {
                                context.showSuccessSnackbar(
                                  "Claim Success".hardCoded,
                                );
                              }
                            }
                          },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: AppColor.accentColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: claimState.isLoading
                                ? const SizedBox(
                                    height: 15.0,
                                    width: 15.0,
                                    child: CircularProgressIndicator(
                                      color: AppColor.textColor,
                                    ),
                                  )
                                : Text(
                                    AppLocalizations.of(context).claim,
                                    style: const TextStyle(
                                      color: AppColor.textColor,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const KDatePickerWidget(),
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.accentColor),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      value: dropDownValue,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        ref
                            .watch(dateController.notifier)
                            .changeDateAndGameType(
                                type: newValue == 'Crypto 2D'
                                    ? 'c2d'
                                    : newValue!);
                        setState(() {
                          dropDownValue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                    AppLocalizations.of(context).noReferralHistory.hardCoded,
                    style:
                        AppTextStyle.yellowMedium.copyWith(color: Colors.white),
                  ),
                );
              }
              return ListView.builder(
                itemCount: list.length,
                padding: const EdgeInsets.symmetric(vertical: 15),
                itemBuilder: (context, index) {
                  final history = list[index];
                  return Card(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        _buildRow(
                          "Name :",
                          "${history.user!.name}",
                        ),
                        _buildRow("Amount :", "${history.amount}MMK"),
                        _buildRow(
                          "Date :",
                          "${gFormatTimeToLocalDate(history.createdAt.toString())}",
                        ),
                        _buildRow("Time :", "${history.section}")
                      ],
                    ),
                  ));
                  // subtitle: Row(
                  //   children: [
                  //     Expanded(child: _buildText(history.section.toString())),
                  //     _buildText("${history.amount} MMK"),
                  //   ],

                  // children: history.section!
                  //     .map(
                  //       (e) => ExpansionChildWidget(
                  //     label: e.betNumber!,
                  //     content: e.amount.toString(),
                  //   ),
                  // )
                  //     .toList());
                },
              );
            },
            error: (msg) => AppErrorWidget(
              error: msg,
              onRetry: () {
                ref.invalidate(referralController);
              },
            ),
          ))
        ]),
      ),
    );
  }

  Row _buildRow(String title, String text) => Row(
        children: [
          Expanded(
              flex: 1,
              child: Text(
                title,
                style: TextStyle(color: AppColor.greyTextColor),
              )),
          Expanded(child: Text(text)),
        ],
      );

  // Text _buildText(String text) => Text(
  //       text,
  //       style: TextStyle(color: AppColor.accentColor),
  //     );
}
