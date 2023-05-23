import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';



class ListTileRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? callback;

  const ListTileRow({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
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
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.accentColor,
        ),
        child: Icon(
          icon,
          color: AppColor.textColor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppColor.accentColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: subtitle != null? Text(
        subtitle??"",
        style: TextStyle(
          color: AppColor.greyTextColor,
        ),
      ):null,
    );
  }
}
