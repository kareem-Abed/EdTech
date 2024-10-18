import 'package:flutter/material.dart';

class KProductTitleText extends StatelessWidget {
  const KProductTitleText({
    super.key,
    this.smallSize = false,
    this.centered = false,
    required this.title,
    this.maxLines = 2,
    this.textAlign = TextAlign.center,
  });
  final bool smallSize;
  final bool centered;
  final int maxLines;
  final String title;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {

    return Text(
      title,

      style: smallSize
          ? Theme.of(context).textTheme.bodyMedium
          : Theme.of(context).textTheme.titleLarge,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}
