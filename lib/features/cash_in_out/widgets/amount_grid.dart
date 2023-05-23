import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';


final selectedAmountController =
StateProvider.autoDispose<String?>((ref) => null);
class AmountGrid extends ConsumerWidget {
  final TextEditingController controller;

  const AmountGrid(this.controller, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = [1000, 3000, 5000, 10000, 30000, 50000, 100000, 500000];
    final selectedAmount = ref.watch(selectedAmountController);
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        mainAxisExtent: 60,
      ),
      itemBuilder: (context, index) {
        final currentIndex = selectedAmount == list[index].toString();
        return GestureDetector(
          onTap: () {
            controller.text = list[index].toString();
            ref.read(selectedAmountController.notifier).state =
                list[index].toString();
          },
          child: Container(
            decoration: AppTheme.containerDecoration.copyWith(
              color: currentIndex ? AppColor.accentColor : AppColor.secondColor,
            ),
            child: Stack(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    list[index].toString(),
                    style: AppTextStyle.yellowMedium.copyWith(
                      color: currentIndex
                          ? AppColor.greyTextColor
                          : AppColor.accentColor,
                    ),
                  ),
                ),
                Positioned(right: 1, child: Icon(currentIndex?Icons.check_circle: null,color: Colors.green,size: 20,))
              ],
            ),
          ),
        );
      },
    );
  }
}
