import 'package:flutter/material.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_primary_button.dart';
import 'package:nommia_crypto/utils/asset_utils.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';
import 'package:nommia_crypto/utils/theme/app_gradient.dart';
import 'package:sizer/sizer.dart';

void showDepositDialog(
  BuildContext context, {
  required String title,
  required Widget description,
  required VoidCallback onDone,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColor.c0C1010, // your dark BG
        child: SizedBox(
          width: cw(500),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: ch(37)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AssetUtils.frameIcon,
                  height: ch(80),
                  fit: BoxFit.contain,
                ),

                SizedBox(height: ch(18)),

                // 🔥 Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppFontSize.f20,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    color: AppColor.cFFFFFF,
                  ),
                ),

                SizedBox(height: ch(30)),

                // 📝 Description
                description,

                SizedBox(height: ch(30)),

                // 🎉 Done Button with Golden Gradient
                AppButton(
                  onPressed: onDone,
                  text: "Done",
                  isButtonEnable: true,
                  isBorder: false,
                  buttonColor: null,
                  buttonStyle: BoxDecoration(
                    gradient: AppGradients.goldenBtn,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: ch(44),
                  width: cw(130),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
