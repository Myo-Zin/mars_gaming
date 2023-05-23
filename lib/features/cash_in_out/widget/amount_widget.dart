
import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';


class AmountWidget extends StatelessWidget {
  final int amount;
  const AmountWidget({super.key,required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
      borderRadius:const BorderRadius.all(Radius.circular(10)),
      color: AppColor.accentColor,
    ),
    margin:const EdgeInsets.only(right: 10),
    padding:const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
    child:Text(amount.toString(),style:const TextStyle(color: AppColor.textColor),),
  );
  }
}