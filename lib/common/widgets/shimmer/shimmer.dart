import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/helpers/helper_functions.dart';

class KShimmerEffect extends StatelessWidget {
  const KShimmerEffect(
      {super.key,
       this.width,
       this.hight,
      this.radius = 15,
      this.color,
      this.child});

  final double? width, hight, radius;
  final Color? color;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: child ??
          Container(
            width: width,
            height: hight,
            decoration: BoxDecoration(
              color: color ?? (dark ? KColors.darkerGrey : KColors.white),
              borderRadius: BorderRadius.circular(radius!),
            ),
          ),
    );
  }
}
