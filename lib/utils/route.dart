

import 'package:flutter/material.dart';

goto(BuildContext context, {required Widget page}) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}