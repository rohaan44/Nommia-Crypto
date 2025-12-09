import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nommia_crypto/utils/color_utils.dart';

void mainBottomsheet({
  required BuildContext context,
  modalContent,
  isBorderRadius = true,
  bottomSheetCloseHandler,
  isDismissible = true,
  enableDrag = true,
  barrierColor,
}) {
  bool flag = false;

  // ProviderScope.containerOf(context).read(appNotifierProvider).isDrag =
  //     enableDrag;

  if (flag == false) {
    flag = true;
    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(isBorderRadius ? 15 : 0),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      barrierColor: barrierColor ?? AppColor.black.withOpacity(0.7),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            // ignore: avoid_unnecessary_containers
            child: Container(
              // color: Colors.blue,
              child: Wrap(children: [modalContent]),
            ),
          ),
        );
      },
    ).whenComplete(() {
      flag = !flag;
      if (bottomSheetCloseHandler != null) {
        bottomSheetCloseHandler();
      }
    });
  }
}
