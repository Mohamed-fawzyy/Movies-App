// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final bool? overFLow;
  final bool? isBold;
  final bool? isItalic;
  final TextAlign? aling;
  MyText({
    Key? key,
    required this.text,
    this.size,
    this.color,
    this.isBold = false,
    this.aling,
    this.overFLow = false,
    this.isItalic = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontStyle: isItalic == true ? FontStyle.italic : null,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
        overflow: overFLow == true ? TextOverflow.ellipsis : null,
      ),
      textAlign: aling,
    );
  }
}
