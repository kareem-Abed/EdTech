import 'package:flutter/material.dart';
import 'package:edtech/common/widgets/custom_shaps/containers/circular_container.dart';
import 'package:edtech/common/widgets/custom_shaps/curved_edges/curved_edges_widget.dart';
import 'package:edtech/utils/constants/colors.dart';

class KPrimaryHeaderContainer extends StatelessWidget {
  const KPrimaryHeaderContainer({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return KCurvedEdgWidget(
      child: Container(
          color: KColors.primary,
          padding: const EdgeInsets.all(0),
          child: SizedBox(
           // height: 400,
            child: Stack(
              children: [
                Positioned(
                    top: -150,
                    right: -250,
                    child: KCircularContainer(
                      backgroundColor: KColors.white.withOpacity(0.1),
                    )),
                Positioned(
                    top: 100,
                    right: -300,
                    child: KCircularContainer(
                      backgroundColor: KColors.white.withOpacity(0.1),
                    )),
                child,
              ],
            ),
          )),
    );
  }
}
