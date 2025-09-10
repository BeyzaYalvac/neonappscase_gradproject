import 'package:flutter/material.dart';

extension AlignmentExt on Widget {
  Widget withAlignment(Alignment alignment) {
    return Align(alignment: alignment, child: this);
  }
}

extension PaddingExt on Widget {
  Widget withPadding(EdgeInsetsGeometry padding) {
    return Padding(padding: padding, child: this);
  }
}

extension CenterExt on Widget {
  Widget withCenter() {
    return Center(child: this);
  }
}

extension ExpandedExt on Widget {
  Widget withExpanded() {
    return Expanded(child: this);
  }
}

extension SizedBoxExt on Widget {
  Widget withSizedBox({double? height, double? width}) {
    return SizedBox(height: height, width: width, child: this);
  }
}

extension PositionedExt on Widget {
  Widget withPositioned({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: this,
    );
  }
}
