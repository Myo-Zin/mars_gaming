import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/url_constants.dart';


class PaymentListTile extends StatelessWidget {
  final String? image;
  final String? title;
  final VoidCallback? callback;

  const PaymentListTile({
    Key? key,
    required this.image,
    required this.title,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        callback?.call();
      },
      leading: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage('${UrlConst.imagePrefix}$image'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        title??"",
        style: TextStyle(color: AppColor.accentColor),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppColor.greyTextColor,
        size: 16,
      ),
    );
  }
}
