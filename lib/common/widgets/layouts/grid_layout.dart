import 'package:flutter/material.dart';
import 'package:edtech/utils/constants/sizes.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class KGridLayout extends StatelessWidget {
  const KGridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 288,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.scrollDirection = Axis.vertical,
  });
  final int itemCount, crossAxisCount;
  final double? mainAxisExtent;
  final Axis scrollDirection;
  final Widget? Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 4,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      scrollDirection: scrollDirection,
  //    physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: KSizes.gridViewSpacing,
        mainAxisSpacing: KSizes.gridViewSpacing,
        mainAxisExtent: 288,
      ),
      itemBuilder: itemBuilder,
    );
  }
}

//
class TGridLayout2 extends StatelessWidget {
  const TGridLayout2({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 288,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = true,
    this.physics = const NeverScrollableScrollPhysics(),
  });
  final int itemCount, crossAxisCount;
  final double? mainAxisExtent;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Widget? Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      itemCount: itemCount,
      shrinkWrap: shrinkWrap,
      padding: EdgeInsets.zero,
      scrollDirection: scrollDirection,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: KSizes.gridViewSpacing,
      mainAxisSpacing: KSizes.gridViewSpacing,
      physics: physics,
      itemBuilder: itemBuilder,
    );
  }
}
//
