import 'package:flutter/material.dart';
import 'package:edtech/common/widgets/custom_shaps/curved_edges/curved_edges.dart';

class KCurvedEdgWidget extends StatelessWidget {
  const KCurvedEdgWidget({
    super.key, required this.child,
  });
final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: KCustomCurvedEdges(),
      child: child
    );
  }
}

