import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/features/2d/models/two_d.dart';
import 'package:mars_gaming/features/2d/pages/two_d_bet_review_page.dart';
import 'package:mars_gaming/utils/extension.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/route.dart';
import '../../profile/providers/providers.dart';
import '../is_twod_avaliable.dart';
import '../providers/providers.dart';
import '../widgets/quick_select_bottom_sheet.dart';

class TwoDBettingPage extends ConsumerStatefulWidget {
  const TwoDBettingPage({
    super.key,
    required this.section,
  });

  final String section;

  @override
  ConsumerState<TwoDBettingPage> createState() => _TwoDBettingPageState();
}

class _TwoDBettingPageState extends ConsumerState<TwoDBettingPage> {
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(twoDController.notifier).getTwoDList(widget.section);
    });
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTwoD = ref.watch(selectedTwoDController);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${AppLocalizations.of(context).section}: ${widget.section}",
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(twoDController.notifier).clearAll();
            },
            icon: selectedTwoD.isEmpty
                ? const Icon(
                    CupertinoIcons.trash,
                    color: Colors.red,
                  )
                : Badge(
                    //badgeColor: AppColor.accentColor,
                    label: Text('${selectedTwoD.length}'),
                    child: const Icon(
                      CupertinoIcons.trash,
                      color: Colors.red,
                    ),
                  ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          const BalanceCard(),
          Divider(
            color: AppColor.accentColor,
          ),
          _QuickSelectRow(ref: ref),
          _TextFieldRow(
            amountController: amountController,
            section: widget.section,
          ),
          const SizedBox(height: 10),
          const _BetNumberGridView(),
        ],
      ),
    );
  }
}

class BalanceCard extends ConsumerWidget {
  const BalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.watch(profileControllerProvider);
    return profileController.map(
        loading: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (pfData) {
          return Row(
            //mainAxisAlignment: MainAxisAlignment.end,

            children: [
              const SizedBox(width: 8,),
              Expanded(child: Text(AppLocalizations.of(context).balance)),
              const SizedBox(width: 8,),
              Text(
                "${pfData.profileData.balance} MMK",
                style: AppTextStyle.yellowTitle,
              ),
              const SizedBox(width: 8,)
            ],
          );
        },
        unAuthenticated: (_) => const Text(""),
        error: (error) => Text("$error"));
  }
}

class _BetNumberGridView extends ConsumerWidget {
  const _BetNumberGridView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final twoDState = ref.watch(twoDController);
    return Expanded(
      child: twoDState.when(
        data: (twoDList) => GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: twoDList.length,
          itemBuilder: (BuildContext context, int index) {
            bool isAvaliable = isTwoDAvalible(twoDList[index]);

            return GestureDetector(
              onTap: () {
                if (isAvaliable) {
                  ref.read(twoDController.notifier).select(twoDList[index].id!);
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: twoDList[index].isSelected == true
                      ? AppColor.accentColor
                      : !isAvaliable
                          ? Colors.red
                          : null,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  twoDList[index].betNumber!,
                  style: TextStyle(
                    color: twoDList[index].isSelected == true
                        ? Colors.black
                        : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
        error: (e, s) => Center(
          child: Text(e.toString()),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _TextFieldRow extends ConsumerWidget {
  const _TextFieldRow({
    Key? key,
    required this.amountController,
    required this.section,
  }) : super(key: key);

  final TextEditingController amountController;
  final String section;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectTwoD = ref.watch(selectedTwoDController);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black, height: 1.5),
              autofocus: false,
              autocorrect: true,
              decoration: InputDecoration(
                errorStyle:
                    const TextStyle(height: 0, color: Colors.transparent),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                isDense: true,
                fillColor: Colors.white,
                filled: true,
                hintText: AppLocalizations.of(context).amount.hardCoded,
                hintStyle: const TextStyle(
                    color: Colors.black, fontSize: 14.0, height: 1.2),
                prefixIcon:
                    const Icon(Icons.paid, size: 18, color: Colors.black),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(3.0),
                    gapPadding: 3.0),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(3.0),
                    gapPadding: 3.0),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(3.0),
                    gapPadding: 3.0),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(3.0),
                    gapPadding: 3.0),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Amount can't be blank".hardCoded;
                } else if (!RegExp(r'(^\-?\d*\.?\d*)$').hasMatch(value)) {
                  return "Invalid bet amount".hardCoded;
                } else if (value.isNotEmpty || value.length > 8) {
                  return "Invalid bet amount".hardCoded;
                } else {
                  return null;
                }
              },
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                if (amountController.text.isEmpty) {
                  context.showErrorSnackbar("Please enter amount".hardCoded);
                  return;
                }
                if (_checkAmount(context, selectTwoD,
                    double.parse(amountController.text), section)) {
                  return;
                }
                FocusScope.of(context).unfocus();
                goto(
                  context,
                  page: BetPreviewPage(
                    amount: double.parse(amountController.text),
                    section: section,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.accentColor,
                minimumSize: const Size(50, 50),
              ),
              child: Text(AppLocalizations.of(context).bet.hardCoded),
            ),
          ),
        ],
      ),
    );
  }

  bool _checkAmount(BuildContext context, List<TwoD> towList,
      double amount, String section) {
    bool result = true;
    for (final cryptoTwoD in towList) {
      if (amount < cryptoTwoD.defaultAmount!) {
        context.showErrorSnackbar(
            "A Least ${cryptoTwoD.defaultAmount!}".hardCoded);
        result = true;
      } else if (amount > cryptoTwoD.overallAmount!) {
        context
            .showErrorSnackbar("Limit ${cryptoTwoD.overallAmount!}".hardCoded);
        result = true;
      } else {
        result = false;
      }
    }
    return result;
  }
}

class _QuickSelectRow extends StatelessWidget {
  const _QuickSelectRow({
    Key? key,
    required this.ref,
  }) : super(key: key);

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 5.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
              ),
              onPressed: () {
                showQuickSelectBottomSheet(context);
              },
              child: Text(
                "Quick".hardCoded,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade800,
              ),
              onPressed: () {
                ref.read(twoDController.notifier).reverse();
              },
              child: const Text(
                "R",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
