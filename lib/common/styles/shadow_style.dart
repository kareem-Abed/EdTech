import 'package:flutter/material.dart';
import 'package:edtech/utils/constants/colors.dart';

class KShadowStyle {
  static final BoxShadow verticalProductShadow = BoxShadow(
    color: KColors.darkGrey.withOpacity(0.1),
    offset: const Offset(0, 2),
    spreadRadius: 7,
    blurRadius: 50,
  );

}
