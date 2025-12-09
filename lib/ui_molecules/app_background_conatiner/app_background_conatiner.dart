import 'package:flutter/material.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:sizer/sizer.dart';

Widget appBackgroundContainer({
  required List<Widget> children,
  bool? isFixedBackground = false,
  bool isScroll = true,
  bool isAppDismissKeyboard = false,
  bool useAlternateBg = false,
  Future<void> Function()? onRefresh,
}) {
  Widget background = _appBackground(children, useAlternateBg);

  if (onRefresh != null && isScroll) {
    background = RefreshIndicator(
      onRefresh: onRefresh,
      child: _fixedBackground(background, true),
    );
  } else if (isFixedBackground == true) {
    background = _fixedBackground(background, isScroll);
  }
  if (isAppDismissKeyboard) {
    background = GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: background,
    );
  }

  return background;
}

Widget _appBackground(List<Widget> children, bool useAlternateBg) {
  return Container(
    height: 100.h,
    width: 100.w,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColor.c121717.withOpacity(0.1),
          AppColor.c121717.withOpacity(0.76),
          AppColor.c121717,
          AppColor.c121717,
        ],
      ),
      // image: DecorationImage(
      //   image: AssetImage(
      //     useAlternateBg ? AssetUtils.ctSplash : AssetUtils.ctTheme,
      //   ),
      //   filterQuality: FilterQuality.high,
      //   fit: BoxFit.cover,
      // ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );
}

Widget _fixedBackground(Widget child, bool isScroll) {
  return SingleChildScrollView(
    physics: isScroll
        ? const AlwaysScrollableScrollPhysics()
        : const NeverScrollableScrollPhysics(),
    child: child,
  );
}
