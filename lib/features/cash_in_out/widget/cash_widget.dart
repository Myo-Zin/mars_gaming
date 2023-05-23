import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../widgets/amount_widget.dart';


class CashWidget extends StatefulWidget {
  final String name;
  final String image;
  final List<int> moneyList;
  final String? buttonName;
  const CashWidget(
      {super.key,
      required this.name,
      required this.image,
      required this.moneyList,
      this.buttonName});

  @override
  State<CashWidget> createState() => _CashWidgetState();
}

class _CashWidgetState extends State<CashWidget> {
  late TextEditingController nameTextController;
  late TextEditingController accountTextController;
  late TextEditingController quantityTextController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameTextController = TextEditingController();
    accountTextController = TextEditingController();
    quantityTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showCashBox(context);
      },
      child: Container(
        height: 180,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            image: DecorationImage(
                image: AssetImage(widget.image), fit: BoxFit.cover)),
      ),
    );
  }

  void showCashBox(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: StatefulBuilder(
              builder: (context, setState) {
                return Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(
                          child: Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.accentColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: nameTextController,
                          decoration: AppTheme.authTextFieldDecoration.copyWith(
                            hintText: "Name",
                            prefixIcon: const Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: accountTextController,
                          keyboardType: TextInputType.number,
                          decoration: AppTheme.authTextFieldDecoration.copyWith(
                            hintText: "Account",
                            prefixIcon: const Icon(Icons.person_add),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: quantityTextController,
                          keyboardType: TextInputType.number,
                          decoration: AppTheme.authTextFieldDecoration.copyWith(
                            hintText: "Amount",
                            prefixIcon: const Icon(Icons.add),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height: height * 0.04,
                            width: width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.moneyList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      quantityTextController.text =
                                          widget.moneyList[index].toString();
                                      setState;
                                    },
                                    child: Center(
                                      child: AmountWidget(
                                          amount: widget.moneyList[index]),
                                    ),
                                  );
                                })),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(widget.buttonName ?? 'Cash In'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
