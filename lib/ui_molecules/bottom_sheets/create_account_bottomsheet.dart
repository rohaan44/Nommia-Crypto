import 'package:flutter/material.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_primary_button.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/ui_molecules/primary_textfield.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';
import 'package:sizer/sizer.dart';

Widget createAccountBottomesheet({
  required BuildContext context,
  double? sheetHeight,
  required String heading,
  required String title1,
  required String title2,
  String? title3,
  required String hint1,
  required String hint2,
  String? hint3,

  String? primarybtnText,
  VoidCallback? primarybtnHandler,
  String? secondarybtnText,
  VoidCallback? secondarybtnHandler,
  double? iconHeight, // new dynamic height
  double? iconWidth, // new dynamic width
  Color? iconColor, // new dynamic color
  String? icon,
  bool isSvgImage = false,
}) {
  return Container(
    height: sheetHeight ?? ch(571),
    width: 100.w,
    decoration: BoxDecoration(color: AppColor.fieldBg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ch(24)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: cw(30)),
          child: Row(
            children: [
              AppText(
                txt: heading,
                fontSize: AppFontSize.f16,
                fontWeight: FontWeight.w600,
                color: AppColor.cFFFFFF,
                height: 1.3,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: ch(16)),

        Container(
          height: ch(1),
          width: 100.w,
          decoration: BoxDecoration(
            color: AppColor.c454F5C,
            borderRadius: BorderRadius.circular(cw(50)),
          ),
        ),
        SizedBox(height: ch(40)),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: cw(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                txt: title1,
                fontSize: AppFontSize.f14,
                fontWeight: FontWeight.w500,
                color: AppColor.cFFFFFF,
                height: 1.3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ch(10)),
              primaryTextField(
                hintText: hint1,
                border: InputBorder.none,

                fillColor: AppColor.c0C1010,
              ),
              SizedBox(height: ch(18)),
              AppText(
                txt: title2,
                fontSize: AppFontSize.f14,
                fontWeight: FontWeight.w500,
                color: AppColor.cFFFFFF,
                height: 1.3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ch(10)),
              primaryTextField(
                hintText: hint2,
                border: InputBorder.none,

                fillColor: AppColor.c0C1010,
              ),
              SizedBox(height: ch(18)),
              if (title3.toString().isNotEmpty) ...[
                AppText(
                  txt: title3 ?? "title empty",
                  fontSize: AppFontSize.f14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.cFFFFFF,
                  height: 1.3,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: ch(10)),
                primaryTextField(
                  hintText: hint3 ?? "",
                  border: InputBorder.none,
                  fillColor: AppColor.c0C1010,
                ),
              ],
            ],
          ),
        ),

        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: cw(30)),
          child: Row(
            children: [
              if (primarybtnHandler != null)
                Expanded(
                  child: InkWell(
                    onTap: primarybtnHandler,
                    child: AppButton(
                      height: ch(48),
                      isButtonEnable: false,
                      onPressed: primarybtnHandler,
                      text: primarybtnText ?? "Cancel",
                    ),
                  ),
                ),

              // Close button
              if (secondarybtnHandler != null) ...[
                SizedBox(width: ch(16)),
                Expanded(
                  child: AppButton(
                    isButtonEnable: true,
                    height: ch(48),
                    onPressed: secondarybtnHandler,
                    text: secondarybtnText ?? "Ok",
                  ),
                ),
              ],
            ],
          ),
        ),

        SizedBox(height: ch(24)),
      ],
    ),
  );
}
