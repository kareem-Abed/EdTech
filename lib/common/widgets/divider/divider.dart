import 'package:flutter/material.dart';
import 'package:edtech/utils/constants/sizes.dart';

class KDivider extends StatelessWidget {
  const KDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: KSizes.sm,
        ),
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        SizedBox(
          height: KSizes.sm,
        ),
      ],
    );
  }
}
