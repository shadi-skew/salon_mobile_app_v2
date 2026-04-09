import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BorderRadiusManager {
  BorderRadiusManager._();
  static final BorderRadius radiusAll10 = BorderRadius.circular(10).r;
  static final BorderRadius radiusAll40 = BorderRadius.circular(40).r;
  static final BorderRadius radiusAll20 = BorderRadius.circular(20).r;

  /// Get border radius for a list item based on position
  static BorderRadius getListItemRadius(int index, int totalItems) {
    if (totalItems == 1) {
      return BorderRadius.circular(8);
    }

    if (index == 0) {
      return const BorderRadius.only(
        topRight: Radius.circular(8),
        topLeft: Radius.circular(8),
        bottomLeft: Radius.circular(2),
        bottomRight: Radius.circular(2),
      );
    } else if (index == totalItems - 1) {
      return const BorderRadius.only(
        bottomRight: Radius.circular(8),
        bottomLeft: Radius.circular(8),
        topLeft: Radius.circular(2),
        topRight: Radius.circular(2),
      );
    } else {
      return BorderRadius.circular(2);
    }
  }
}
