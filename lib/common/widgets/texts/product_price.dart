
import 'package:flutter/material.dart';

class KProductPriceText extends StatelessWidget {
  const KProductPriceText({
    super.key,
    this.currencySign = 'ج.م',
    required this.price,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineTheough = false,
  });

  final String currencySign, price;
  final int maxLines;

  final bool isLarge, lineTheough;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$price $currencySign',
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
                decoration: lineTheough ? TextDecoration.lineThrough : null,
                decorationColor: Colors.red,
                decorationStyle: TextDecorationStyle.double,
              )
          : Theme.of(context).textTheme.titleLarge!.apply(
                decoration: lineTheough ? TextDecoration.lineThrough : null,
                decorationColor: Colors.red,
                decorationStyle: TextDecorationStyle.double,
              ),
    );
  }
}
