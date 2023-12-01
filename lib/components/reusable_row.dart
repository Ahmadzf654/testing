

import 'package:flutter/material.dart';

class ReUsableRow extends StatelessWidget {
  String title, value;
  ReUsableRow({super.key ,required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const  EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: Text(title)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}