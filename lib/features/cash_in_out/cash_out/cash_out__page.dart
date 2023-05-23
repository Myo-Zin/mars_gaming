
import 'package:flutter/material.dart';


import '../../../utils/app_color.dart';
import '../widget/cash_widget.dart';
class CashOutPage extends StatefulWidget {
  const CashOutPage({super.key});

  @override
  State<CashOutPage> createState() => _CashInPageState();
}

class _CashInPageState extends State<CashOutPage> {
  @override
  Widget build(BuildContext context) {
    var cashInList=[3000,5000,10000,500000,1000000];
    return Scaffold(
      appBar: AppBar(
        title:const Text('Cash Out'),
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
              CashWidget(name: 'K Pay',image: 'assets/kpay.png',moneyList: cashInList,buttonName: 'Cash Out',),
              const SizedBox(
                height: 20,
              ),
              CashWidget(name: 'AYA Pay',image: 'assets/aya.png',moneyList: cashInList,buttonName: 'Cash Out',),
              const SizedBox(
                height: 20,
              ),
              CashWidget(name: 'Wavemoney',image: 'assets/wavemoney.png',moneyList: cashInList,buttonName: 'Cash Out',),
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
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CashWidget(name: 'K Pay',image: 'assets/kpay.png',moneyList: cashInList,buttonName: 'Cash Out',),
                              const SizedBox(
                  width: 20,
                              ),
                       CashWidget(name: 'AYA Pay',image: 'assets/aya.png',moneyList: cashInList,buttonName: 'Cash Out',),
                             
                      
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