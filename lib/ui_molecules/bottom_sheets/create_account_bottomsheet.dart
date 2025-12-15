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
  String title3 = "",
  required String hint1,
  required String hint2,
  String? hint3,
  String description = "",
  String? primarybtnText,
  VoidCallback? primarybtnHandler,
  String? secondarybtnText,
  VoidCallback? secondarybtnHandler,
  double? iconHeight, // new dynamic height
  double? iconWidth, // new dynamic width
  Color? iconColor, // new dynamic color
  String? icon,
  bool isDivider = true,
  bool isDropDown = false,
  bool isSvgImage = false,
}) {
  String selectedValue = "Equity";

  return Container(
    height: sheetHeight ?? ch(571),
    width: 100.w,
    decoration: BoxDecoration(
      color: AppColor.fieldBg,

      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(cw(20)),
        topRight: Radius.circular(cw(20)),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ch(24)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: cw(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                txt: heading,
                fontSize: AppFontSize.f14,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 251, 251, 251),
                height: 1.3,
                textAlign: TextAlign.center,
              ),
              if (description.isNotEmpty) ...[
                SizedBox(height: ch(5)),
                AppText(
                  txt: description,
                  fontSize: AppFontSize.f12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.grey,
                  height: 1.3,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: ch(16)),
        if (isDivider)
          Container(
            height: ch(1),
            width: 100.w,
            decoration: BoxDecoration(
              color: AppColor.c454F5C,
              borderRadius: BorderRadius.circular(cw(50)),
            ),
          ),
        SizedBox(height: ch(10)),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: cw(30)),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
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
                  if (isDropDown) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(cw(14)),
                        border: Border.all(color: AppColor.fieldBg),
                        color: AppColor.c0C1010,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedValue,
                            dropdownColor: AppColor.c0C1010,
                            icon: SizedBox.shrink(),
                            items: <String>['Equity', 'Percent', 'Lot Ratio']
                                .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: AppText(
                                      txt: value,
                                      color: AppColor.white,
                                    ),
                                  );
                                })
                                .toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedValue = newValue;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ] else
                    primaryTextField(
                      hintText: hint1,
                      border: InputBorder.none,
                      fillColor: AppColor.c0C1010,
                    ),
                  SizedBox(height: ch(18)),
                  AppText(
                    txt: selectedValue == 'Percent'
                        ? 'Percent'
                        : selectedValue == 'Lot Ratio'
                        ? 'Multiplier'
                        : title2,
                    fontSize: AppFontSize.f14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.cFFFFFF,
                    height: 1.3,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: ch(10)),
                  primaryTextField(
                    hintText: selectedValue == 'Percent'
                        ? 'Enter Percent'
                        : selectedValue == 'Lot Ratio'
                        ? 'Enter Multiplier'
                        : hint2,
                    border: InputBorder.none,
                    fillColor: AppColor.c0C1010,
                  ),
                  SizedBox(height: ch(18)),
                  if (title3.isNotEmpty) ...[
                    AppText(
                      txt: title3,
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
              );
            },
          ),
        ),

        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: cw(30)),
          child: Row(
            children: [
              if (primarybtnHandler != null)
                Expanded(
                  child: AppButton(
                    height: ch(40),
                    isButtonEnable: false,
                    onPressed: primarybtnHandler,
                    text: primarybtnText ?? "Cancel",
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
                    text: secondarybtnText ?? "Okay",
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
