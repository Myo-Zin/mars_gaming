import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'l10n.dart';
import 'local_provider.dart';

String myanmar = "🇲🇲";
String english = "🇬🇧";
String chinese = "🇨🇳";
String thai = "🇹🇭";

List<Widget> chooseLanguageListWidget(BuildContext context, WidgetRef ref) {
  return [
    InkWell(
        onTap: () {
          ref.read(localProvider.notifier).setLocal(L10n.all[0]);
          Navigator.pop(context);
        },
        child: _buildRow(myanmar, "Myanmar")),
    InkWell(
        onTap: () {
          ref.read(localProvider.notifier).setLocal(L10n.all[1]);
          Navigator.pop(context);
        },
        child: _buildRow(english, "English")),
    InkWell(
        onTap: () {
          ref.read(localProvider.notifier).setLocal(L10n.all[2]);
          Navigator.pop(context);
        },
        child: _buildRow(chinese, "Chinese")),
    InkWell(
        onTap: () {
          ref.read(localProvider.notifier).setLocal(L10n.all[3]);
          Navigator.pop(context);
        },
        child: _buildRow(thai, "Thai")),
  ];
}

Widget _buildRow(String flag, String lan) {
  return Padding(
    padding: const EdgeInsets.only(left: 30, top: 20),
    child: Row(
      children: [
        Text(
          flag,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 30,
        ),
        Text(lan)
      ],
    ),
  );
}
