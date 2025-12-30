import 'package:flutter/material.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_primary_button.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/utils/asset_utils.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';

void showDepositDialog(
  BuildContext context, {
  required String title,
  required Widget description,
  required VoidCallback onDone,
  String image = AssetUtils.frameIcon,
  FontWeight fontWeight = FontWeight.w600,
  double? fontSize,
  bool isDeposit = false,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColor.c0C1010, // your dark BG
        child: SizedBox(
          width: cw(600),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: ch(37)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isDeposit)
                  AppText(
                    txt: "Deposit USDT - TRC20",
                    fontSize: AppFontSize.f20,
                    fontWeight: FontWeight.w400,
                  ),
                SizedBox(height: ch(15)),
                Image.asset(image, height: ch(150), fit: BoxFit.contain),

                SizedBox(height: ch(18)),

                // 🔥 Title
                AppText(
                  txt: isDeposit
                      ? "Send only USDT - TRC20 to this address."
                      : title,
                  textAlign: TextAlign.center,
                  fontSize: isDeposit ? AppFontSize.f14 : AppFontSize.f22,
                  fontWeight: isDeposit ? FontWeight.w400 : FontWeight.w500,
                  height: 1.5,
                  color: isDeposit ? AppColor.c838585 : AppColor.cFFFFFF,
                ),

                SizedBox(height: ch(10)),

                // 📝 Description
                description,

                SizedBox(height: ch(30)),

                // 🎉 Done Button with Golden Gradient
                AppButton(
                  onPressed: onDone,
                  text: "OK",
                  isButtonEnable: true,
                  isBorder: false,
                  buttonColor:
                      AppColor.accentYellow, // Use yellow as per screenshot
                  textColor: AppColor.black,
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
