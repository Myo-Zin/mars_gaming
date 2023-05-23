import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/app_color.dart';
import '../../2d/widgets/quick_select_button.dart';
import '../providers/providers.dart';

class QuickSelectThreeD extends ConsumerWidget {
  const QuickSelectThreeD({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController textEditingController = TextEditingController();
    return Container(
      // height: 300,
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Quick",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: AppColor.accentColor,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
              GridView.extent(
                  padding: const EdgeInsets.all(12),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  maxCrossAxisExtent: 50.0,
                  children: [
                    QuickSelectButton(
                      onTap: () {
                        ref.read(threeDController.notifier).pairOdd();
                        Navigator.pop(context);
                      },
                      label: "မပူး",
                    ),
                    QuickSelectButton(
                      onTap: () {
                        ref.read(threeDController.notifier).pairEven();
                        Navigator.pop(context);
                      },
                      label: "စုံပူး",
                    ),
                  ]),
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "Manual Input",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: textEditingController,
                  keyboardType: Platform.isIOS ? null : TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "112,123,115",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.all(10.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      String text = textEditingController.text;
                      if (text.isNotEmpty) {
                        List<String> selectedList = [];
                        if (text.length == 3) {
                          selectedList.add(text);
                        } else {
                          if (text.contains(',')) {
                            final split = text.split(',');
                            for (int i = 0; i < split.length; i++) {
                              if (split[i].length == 3) {
                                selectedList.add(split[i]);
                              }
                            }
                          }
                        }
                        ref
                            .read(threeDController.notifier)
                            .manualInput(selectedList);
                      }
                    },
                    child: const Text("Select"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
