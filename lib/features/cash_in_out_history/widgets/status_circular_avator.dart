import 'package:flutter/material.dart';

class StatusCircularAvator extends StatelessWidget {
  final String? status;
  const StatusCircularAvator({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == "Pending") {
      return const CircleAvatar(
        backgroundColor: Colors.yellow,
        child: Icon(
          Icons.pending,
          color: Colors.black,
        ),
      );
    } else if (status == "Reject") {
      return const CircleAvatar(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.close,
          color: Colors.white,
        ),
      );
    } else {
      return const CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
    }
  }
}
