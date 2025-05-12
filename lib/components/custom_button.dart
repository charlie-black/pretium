import 'package:flutter/material.dart';

import '../utils/text_styling.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double width;
  final double height;
  final double borderRadius;
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;
  final Color textColor;
  final Color borderColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 200,
    this.height = 50,
    this.textColor = Colors.white,
    this.borderRadius = 25,
    this.colors = const [Colors.blue, Colors.green],
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: begin,
            end: end,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor),
        ),
        child: MaterialButton(
          onPressed: () => onPressed(),
          child: Text(text, style: kTitleStyle.copyWith(color: textColor)),
        ),
      ),
    );
  }
}
