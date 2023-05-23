import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/async_value_ui.dart';
import 'package:mars_gaming/utils/extension.dart';


import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../profile/providers/providers.dart';
import '../models/two_d.dart';
import '../providers/providers.dart';
import '../widgets/two_d_bet_edit_dialog.dart';


class BetPreviewPage extends ConsumerStatefulWidget {
  final double amount;
  final String section;

  const BetPreviewPage({
    Key? key,
    required this.amount,
    required this.section,
  }) : super(key: key);

  @override
  ConsumerState<BetPreviewPage> createState() => _BetPreviewState();
}

class _BetPreviewState extends ConsumerState<BetPreviewPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedTwoDController.notifier).addAmount(widget.amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    final twoDList = ref.watch(selectedTwoDController);
    final totalAmount = ref.watch(twoDTotalBetAmountController);
    ref.listen(isNotGetWantedAmountController, (previous, next) {
      if (next == true) {
        showWaringDialogForNotGettingWantedAmount(context);
      }
    });
    ref.listen(twoDBetController, (previous, next) {
      next.showSnackBarOnError(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bet Numbers",
          style: TextStyle(color: AppColor.accentColor),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.accentColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: const [
                  _Title(
                    title: "Num",
                  ),
                  _Title(
                    title: "Odd",
                  ),
                  _Title(
                    title: "Amount",
                  ),
                  _Title(
                    title: "Edit",
                  ),
                  _Title(
                    title: "Delete",
                  ),
                ],
              ),
            ),
            ...List.generate(
              twoDList.length,
              (index) => Row(
                children: [
                  _Title(
                    title: twoDList[index].betNumber!,
                    style: TextStyle(
                      color: twoDList[index].isGetExpectedAmount == true
                          ? Colors.white
                          : Colors.red,
                    ),
                  ),
                  _Title(
                    title: twoDList[index].odd!.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  _Title(
                    title: twoDList[index].betAmount.toString(),
                    style: TextStyle(
                      color: twoDList[index].isGetExpectedAmount == true
                          ? Colors.white
                          : Colors.red,
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        showTwoDEditDialog(
                          context: context,
                          twoD: twoDList[index],
                          formKey: _formKey,
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.greenAccent,
                        size: 18.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        _showDeleteDialog(context, twoDList, index);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          color: AppColor.secondColor,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "count : ${twoDList.length} ကွက်",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "total : $totalAmount kyats",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final betState = ref.watch(twoDBetController);
                    return ElevatedButton(
                      onPressed: betState.isLoading
                          ? () {}
                          : () {
                              final profile =
                                  ref.read(profileControllerProvider);
                              profile.maybeMap(
                                data: (data) async {
                                  final isSuccess = await ref
                                      .read(twoDBetController.notifier)
                                      .bet(
                                        twoDList: twoDList,
                                        section: widget.section,
                                        token: data.profileData.token!,
                                      );
                                  if (mounted && isSuccess) {
                                    context.showSuccessSnackbar(
                                      "Bet Success".hardCoded,
                                    );
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }
                                },
                                orElse: () {},
                              );
                            },
                      child: Center(
                        child: betState.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : Text(
                                "Bet".hardCoded,
                                style: const TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 0.2,
                                  fontSize: 16,
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
      ),
    );
  }

  Future<dynamic> showWaringDialogForNotGettingWantedAmount(
      BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Icon(
            Icons.warning,
            size: 40,
            color: AppColor.accentColor,
          ),
          content: const Text(
            "အနီရောင့်ဖြင့် ပြထားသော ဂဏန်းများမှာ ထိုးကြေးအပြည့် မရတော့ပါ။",
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }

  _showDeleteDialog(
    BuildContext context,
    List<TwoD> twoDList,
    int index,
  ) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete"),
        content: Text('${twoDList[index].betNumber} will be removed'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "CANCEL",
                style: TextStyle(color: Colors.grey.shade500),
              )),
          TextButton(
            onPressed: () {
              ref.read(selectedTwoDController.notifier).delete(
                    twoDList[index].id!,
                  );
              Navigator.of(context).pop();
            },
            child: const Text(
              "CONFIRM",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
    required this.title,
    this.style,
  }) : super(key: key);
  final String title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: style ?? AppTextStyle.yellowMedium,
        ),
      ),
    );
  }
}
