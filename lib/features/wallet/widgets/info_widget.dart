
import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/color_extension.dart';


class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
     final BoxDecoration containerDecoration = BoxDecoration(
      color: AppColor.secondColor,
      borderRadius: BorderRadius.circular(12),
    );
    return Container(
              margin:const EdgeInsets.only(top: 20),
              padding:const EdgeInsets.only(
                right: 20,
                top: 25,
                bottom: 40
              ),
              decoration:containerDecoration,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.accentColor,
                            ),
                            child:const Icon(
                              Icons.arrow_forward,
                              color: AppColor.textColor,
                            ),
                          ),
                          title: Text(
                            'Transition ID:  123456789',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.accentColor,
                            ),
                          ),
                          subtitle:Text(
                            'March 22, 2022',
                             style: TextStyle(
                              color: AppColor.greyTextColor
                             ),
                           ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 33,top: 17,bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name: U Maung Maung',
                              style: TextStyle(color: AppColor.greyTextColor),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text('Account No: 112234567890',
                              style: TextStyle(color: AppColor.greyTextColor),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text('Phone: 0979664646',
                              style: TextStyle(color: AppColor.greyTextColor),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text('Amount: 200,00 MMK',
                              style: TextStyle(color: AppColor.greyTextColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.expand_less_outlined,
                        color: AppColor.accentColor,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: Container(
                       padding: const EdgeInsets.symmetric(
                        horizontal: 10,vertical: 5
                      ),
                      decoration:BoxDecoration(
                        borderRadius:const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: HexColor.fromHex('27CB00'),
                      ),
                      child:const Text(
                        'Approved',
                        style: TextStyle(
                          color: AppColor.textColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
  }
}