import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {
    super.key,
    this.size,
    this.weight,
    this.color,
    this.textAlign,
    this.decoration,
    this.decorationColor,
    this.height,
  });

  final String text;
  final double? size, height;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final Color? decorationColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: size,
            fontWeight: weight,
            color: color ?? Theme.of(context).textTheme.titleMedium?.color,
            decoration: decoration,
            decorationColor: decorationColor,
            height: height,
          ),
      textAlign: textAlign,
    );
  }
}
