// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:todo/ui/theme.dart';

class MyButton extends StatelessWidget {
  MyButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  final String label;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: primaryClr),
          width: 100,
          height: 45,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
