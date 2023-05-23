
import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../widget/cash_widget.dart';
class CashInPage extends StatefulWidget {
  const CashInPage({super.key});

  @override
  State<CashInPage> createState() => _CashInPageState();
}

class _CashInPageState extends State<CashInPage> {
  @override
  Widget build(BuildContext context) {
    var cashInList=[1000,3000,5000,10000,100000,300000,500000];
    return Scaffold(
      appBar: AppBar(
        title:const Text('Cash In'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:const EdgeInsets.only(top: 30,bottom: 20),
                child: Text(
                  'Pay',
                  style: TextStyle(
                  color: AppColor.accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CashWidget(name: 'K Pay',image: 'assets/kpay.png',moneyList: cashInList),
              const SizedBox(
                height: 20,
              ),
              CashWidget(name: 'AYA Pay',image: 'assets/aya.png',moneyList: cashInList),
              const SizedBox(
                height: 20,
              ),
              CashWidget(name: 'Wavemoney',image: 'assets/wavemoney.png',moneyList: cashInList),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:const EdgeInsets.only(top: 20,bottom: 20),
                child: Text(
                  'Banking',
                  style: TextStyle(
                  color: AppColor.accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CashWidget(name: 'K Pay',image: 'assets/kpay.png',moneyList: cashInList),
                              const SizedBox(
                  width: 20,
                              ),
                              CashWidget(name: 'AYA Pay',image: 'assets/aya.png',moneyList: cashInList),
                             
                    ],
                  ),
                ),
              ),
               const SizedBox(
                  height: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}