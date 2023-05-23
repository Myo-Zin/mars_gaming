import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/features/3d/pages/three_d_bet_preview_page.dart';
import 'package:mars_gaming/utils/extension.dart';
import '../../../utils/app_color.dart';
import '../../../utils/route.dart';
import '../../2d/pages/two_d_betting_page.dart';
import '../is_threed_avaliable.dart';
import '../models/three_d.dart';
import '../models/three_d_section.dart';
import '../providers/providers.dart';
import '../providers/three_d_filter_controller.dart';
import '../widgets/three_d_quick_select_dialog.dart';


class ThreeDBettingPage extends ConsumerStatefulWidget {
  final ThreeDSection section;
  const ThreeDBettingPage({
    super.key,
    required this.section,
  });

  @override
  ConsumerState<ThreeDBettingPage> createState() => _ThreeDBettingPageState();
}

class _ThreeDBettingPageState extends ConsumerState<ThreeDBettingPage> {
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //ref.read(threeDController.notifier).getThreeDList();

    //   print("init");
    // });
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedThreeD = ref.watch(selectedThreeDController);
    print("open date ${widget.section.openDate}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${AppLocalizations.of(context).opendate}: ${widget.section.openDate}",
        ),
        actions: [
          IconButton(
            onPressed: () async {
              ref.read(threeDController.notifier).clearAll();
            },
            icon: selectedThreeD.isEmpty
                ? const Icon(
                    CupertinoIcons.trash,
                    color: Colors.red,
                  )
                : Badge(
                    //badgeColor: AppColor.accentColor,
                    label: Text('${selectedThreeD.length}'),
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
          const _QuickSelectRow(),
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

class _BetNumberGridView extends ConsumerWidget {
  const _BetNumberGridView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final threeDState = ref.watch(threeDController);

    return Expanded(
      child: threeDState.when(
        data: (list) {
          final threeDList = ref.watch(filterListController(list));
          return GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: threeDList.length,
            itemBuilder: (BuildContext context, int index) {
              bool isAvaliable = isThreeDAvalible(threeDList[index]);

              return GestureDetector(
                onTap: () {
                  if (isAvaliable) {
                    ref
                        .read(threeDController.notifier)
                        .select(threeDList[index].id!);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: threeDList[index].isSelected == true
                        ? AppColor.accentColor
                        : !isAvaliable
                            ? Colors.red
                            : null,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    threeDList[index].betNumber!,
                    style: TextStyle(
                      color: threeDList[index].isSelected == true
                          ? Colors.black
                          : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
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
    // required this.section,
  }) : super(key: key);

  final TextEditingController amountController;
  final ThreeDSection section;

//  final String section;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final threeDList = ref.watch(selectedThreeDController);
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
                if (_checkAmount(context, threeDList,
                    double.parse(amountController.text))) {
                  return;
                }
                FocusScope.of(context).unfocus();
                goto(
                  context,
                  page: ThreeDBetPreviewPage(
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
  bool _checkAmount(BuildContext context, List<ThreeD> threeDList,
      double amount) {
    bool result = true;
    for (final cryptoTwoD in threeDList) {
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

class _QuickSelectRow extends ConsumerStatefulWidget {
  const _QuickSelectRow({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_QuickSelectRow> createState() => _QuickSelectRowState();
}

class _QuickSelectRowState extends ConsumerState<_QuickSelectRow> {
  String dropDownValue = '000';

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
            flex: 2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
              ),
              onPressed: () {
                showThreeDQuickSelectDialog(context);
              },
              child: const Text(
                "Quick",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade800,
              ),
              onPressed: () {
                ref.read(threeDController.notifier).round();
              },
              child: const Text(
                "Round",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.accentColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    // value: dropDownValue,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    value: ref.watch(threeDListSortTypeProvider),
                    // When the user interacts with the dropdown, we update the provider state.
                    onChanged: (value) => ref
                        .read(threeDListSortTypeProvider.notifier)
                        .state = value!,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
