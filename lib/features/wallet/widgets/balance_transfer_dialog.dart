import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../profile/models/profile_response.dart';
import '../providers/providers.dart';

final _tabIndexNotifier = StateProvider<int>((ref) => 0);
final _amountTextControllerProvider =
    Provider.autoDispose((ref) => TextEditingController());

showBalanceTransferDialog(BuildContext context, ProfileData profileData) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Consumer(builder: (context, ref, child) {
          final selectedIndex = ref.watch(_tabIndexNotifier);
          final state = ref.watch(walletTransferController);
          final amountTextController = ref.watch(_amountTextControllerProvider);
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _TabItem(
                      title: "Main To Game",
                      index: 0,
                    ),
                    _TabItem(
                      title: "Game To Main",
                      index: 1,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: amountTextController,
                    keyboardType: TextInputType.number,
                    decoration: AppTheme.authTextFieldDecoration
                        .copyWith(hintText: "Enter amount"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () async {
                              int amount = 0;
                              if (amountTextController.text.isEmpty) {
                                context
                                    .showErrorSnackbar("Please enter amount");
                                return;
                              }
                              try {
                                amount = int.parse(amountTextController.text);
                              } catch (e) {
                                context.showErrorSnackbar(
                                    "Invalid input! Please type correctly.");
                                return;
                              }

                              final turnover =
                                  double.parse(profileData.turnover ?? "0");
                              final balance =
                                  double.parse((profileData.balance ?? '0'));
                              final gameBalance =
                                  double.parse(profileData.gameBalance ?? '0');

                              if (selectedIndex == 0) {
                                if (amount <= balance) {
                                  await ref
                                      .read(walletTransferController.notifier)
                                      .mainToGameTransfer(
                                        profileData.token!,
                                        amount,
                                      )
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                } else {
                                  context.showErrorSnackbar(
                                      "You don't have enough money to transfer");
                                }
                              } else {
                                if (turnover <= 0) {
                                  if (amount > gameBalance) {
                                    context.showErrorSnackbar(
                                        "You don't have enough money to transfer");
                                    return;
                                  }
                                  await ref
                                      .read(walletTransferController.notifier)
                                      .gameToMainTransfer(
                                        profileData.token!,
                                        amount,
                                      )
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                } else {
                                  context.showErrorSnackbar(
                                      "You can't move when you have turnover greater than 0");
                                }
                              }
                            },
                      child: state.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : const Text("Transfer"),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      );
    },
  );
}

class _TabItem extends ConsumerWidget {
  const _TabItem({
    Key? key,
    required this.index,
    required this.title,
  }) : super(key: key);

  final int index;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(_tabIndexNotifier);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(_tabIndexNotifier.notifier).state = index;
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: AppTheme.containerDecoration.copyWith(
            color: currentIndex == index ? AppColor.accentColor : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: currentIndex == index ? AppColor.textColor : null,
            ),
          ),
        ),
      ),
    );
  }
}
