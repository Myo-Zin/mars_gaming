import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_color.dart';
import '../providers/providers.dart';
import 'quick_select_button.dart';

class QuickSelect extends ConsumerWidget {
  const QuickSelect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 500,
      decoration: const BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Center(
            child: Icon(
              Icons.minimize,
              color: AppColor.accentColor,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  "အမြန်ရွေး",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                GridView.extent(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  maxCrossAxisExtent: 50.0,
                  children: [
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).big();
                        Navigator.pop(context);
                      },
                      label: "ကြီး",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).small();
                        Navigator.pop(context);
                      },
                      label: "ငယ်",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).evenEven();
                        Navigator.pop(context);
                      },
                      label: "စုံစုံ",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).oddOdd();
                        Navigator.pop(context);
                      },
                      label: "မမ",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).evenOdd();
                        Navigator.pop(context);
                      },
                      label: "စုံမ",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).oddEven();
                        Navigator.pop(context);
                      },
                      label: "မစုံ",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).oddPair();
                        Navigator.pop(context);
                      },
                      label: "မပူး",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).evenPair();
                        Navigator.pop(context);
                      },
                      label: "စုံပူး",
                    ),
                  ],
                ),

                //------------------ စုံ/မ ထိပ် ------------------//
                const SizedBox(height: 20),
                const Text("စုံ/မ ထိပ်",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).evenStart();
                        Navigator.pop(context);
                      },
                      label: "စုံထိပ်",
                    ),
                    const SizedBox(width: 12),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).oddStart();
                        Navigator.pop(context);
                      },
                      label: "မထိပ်",
                    ),
                  ],
                ),
                /////////////////// စုံ/မ နောက် ////////////////////
                const SizedBox(height: 20),
                const Text("စုံ/မ နောက်",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).evenEnd();
                        Navigator.pop(context);
                      },
                      label: "စုံနောက်",
                    ),
                    const SizedBox(width: 12),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).oddEnd();
                        Navigator.pop(context);
                      },
                      label: "မနောက်",
                    ),
                  ],
                ),
                //--------------------- ထိပ်စည်း ----------------------//
                const SizedBox(height: 20),
                const Text("ထိပ်စည်း",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                GridView.extent(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  maxCrossAxisExtent: 50.0,
                  children: [
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).start0();
                        Navigator.pop(context);
                      },
                      label: "0",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).start1();
                        Navigator.pop(context);
                      },
                      label: "1",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).start2();
                        Navigator.pop(context);
                      },
                      label: "2",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).start3();
                        Navigator.pop(context);
                      },
                      label: "3",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).start4();
                        Navigator.pop(context);
                      },
                      label: "4",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).start5();
                        Navigator.pop(context);
                      },
                      label: "5",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).start6();
                        Navigator.pop(context);
                      },
                      label: "6",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).start7();
                        Navigator.pop(context);
                      },
                      label: "7",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).start8();
                        Navigator.pop(context);
                      },
                      label: "8",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).start9();
                        Navigator.pop(context);
                      },
                      label: "9",
                    ),
                  ],
                ),

                //--------------တစ်လုံးပတ်----------------//
                const SizedBox(height: 20),
                const Text("တစ်လုံးပတ်",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                GridView.extent(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  maxCrossAxisExtent: 50.0,
                  children: [
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).include0();
                        Navigator.pop(context);
                      },
                      label: "0",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).include1();
                        Navigator.pop(context);
                      },
                      label: "1",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).include2();
                        Navigator.pop(context);
                      },
                      label: "2",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).include3();
                        Navigator.pop(context);
                      },
                      label: "3",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).include4();
                        Navigator.pop(context);
                      },
                      label: "4",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).include5();
                        Navigator.pop(context);
                      },
                      label: "5",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).include6();
                        Navigator.pop(context);
                      },
                      label: "6",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).include7();
                        Navigator.pop(context);
                      },
                      label: "7",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).include8();
                        Navigator.pop(context);
                      },
                      label: "8",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).include9();
                        Navigator.pop(context);
                      },
                      label: "9",
                    ),
                  ],
                ),
                //-------------- နောက်ပိတ် -----------------//
                const SizedBox(height: 20),
                const Text(
                  "နောက်ပိတ်",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                GridView.extent(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  maxCrossAxisExtent: 50.0,
                  children: [
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).end0();
                        Navigator.pop(context);
                      },
                      label: "0",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).end1();
                        Navigator.pop(context);
                      },
                      label: "1",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).end2();
                        Navigator.pop(context);
                      },
                      label: "2",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).end3();
                        Navigator.pop(context);
                      },
                      label: "3",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).end4();
                        Navigator.pop(context);
                      },
                      label: "4",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).end5();
                        Navigator.pop(context);
                      },
                      label: "5",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).end6();
                        Navigator.pop(context);
                      },
                      label: "6",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).end7();
                        Navigator.pop(context);
                      },
                      label: "7",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).end8();
                        Navigator.pop(context);
                      },
                      label: "8",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).end9();
                        Navigator.pop(context);
                      },
                      label: "9",
                    ),
                  ],
                ),
                //-------------- ဘရိတ် ----------------//
                const SizedBox(height: 20),
                const Text("ဘရိတ်",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                GridView.extent(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  maxCrossAxisExtent: 50.0,
                  children: [
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).break0();
                        Navigator.pop(context);
                      },
                      label: "0",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).break1();
                        Navigator.pop(context);
                      },
                      label: "1",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).break2();
                        Navigator.pop(context);
                      },
                      label: "2",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).break3();
                        Navigator.pop(context);
                      },
                      label: "3",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).break4();
                        Navigator.pop(context);
                      },
                      label: "4",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).break5();
                        Navigator.pop(context);
                      },
                      label: "5",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).break6();
                        Navigator.pop(context);
                      },
                      label: "6",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).break7();
                        Navigator.pop(context);
                      },
                      label: "7",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).break8();
                        Navigator.pop(context);
                      },
                      label: "8",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).break9();
                        Navigator.pop(context);
                      },
                      label: "9",
                    ),
                  ],
                ),
                //-------------နတ်က္ခတ် ----------------//
                const SizedBox(height: 20),
                const Text("အခြား",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).star();
                        Navigator.pop(context);
                      },
                      label: "နက္ခတ်",
                    ),
                    const SizedBox(width: 12),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).power();
                        Navigator.pop(context);
                      },
                      label: "ပါဝါ",
                    ),
                    const SizedBox(width: 12),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(cryptoTwoDController.notifier).brother();
                        Navigator.pop(context);
                      },
                      label: "ညီအစ်ကို",
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
