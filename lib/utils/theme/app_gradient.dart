import 'package:flutter/material.dart';
import 'package:nommia_crypto/utils/color_utils.dart';

class AppGradients {
  static LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColor.c121717.withOpacity(0.1),
      AppColor.c121717.withOpacity(0.76),
      AppColor.c121717,
      AppColor.c121717,
    ],
  );
  static LinearGradient goldenBtn = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColor.cBF8C15, AppColor.cDAA934, AppColor.cF4C553],
  );
}
