import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart' show AppFontSize;

Widget primaryTextField({
  required String hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  TextEditingController? controller,
  Function(String)? onChanged,
  Function()? onTap,
  List<TextInputFormatter>? inputFormatters,
  TextInputType? keyboardType,
  TextInputAction? textInputAction,
  bool obscureText = false,
  bool readOnly = false,
  int? maxLength,
  bool autoFocus = false,
  Color? fillColor,
  TextStyle? textStyle,
  TextStyle? hintStyle,
  InputBorder? border,
  bool isBorderColor = false,
  Color? borderColor,
  FocusNode? focusNode,
  double? borderRadius,
  double? textFieldHeight,
}) {
  final fieldHeight = textFieldHeight ?? ch(40);

  return Container(
    height: fieldHeight,
    padding: EdgeInsets.zero,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(cw(borderRadius ?? 14)),
      border: Border.all(color: AppColor.fieldBg),
      color: fillColor ?? AppColor.fieldBg,
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: cw(16)),
      child: Row(
        children: [
          if (prefixIcon != null)
            Padding(
              padding: EdgeInsets.only(left: cw(0), right: cw(8)),
              child: prefixIcon,
            ),
          // SizedBox(width: cw(16)),
          Expanded(
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              readOnly: readOnly,

              autofocus: autoFocus,
              obscureText: obscureText,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              maxLength: maxLength,
              inputFormatters: inputFormatters,
              cursorColor: AppColor.red,

              // 🔥 Cursor Always Center
              textAlignVertical: TextAlignVertical.center,

              style:
                  textStyle ??
                  TextStyle(
                    color: AppColor.white,
                    fontSize: AppFontSize.f14,
                    fontWeight: FontWeight.w500,
                  ),

              decoration: InputDecoration(
                fillColor: fillColor ?? AppColor.fieldBg,
                counterText: "",
                border: InputBorder.none,
                hintText: hintText,
                hintStyle:
                    hintStyle ??
                    TextStyle(
                      fontSize: AppFontSize.f14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.cFFFFFF.withOpacity(0.5),
                    ),

                // 🔥 Perfect vertical centering
                contentPadding: EdgeInsets.zero,

                // Remove inner padding
                isDense: true,
              ),

              onChanged: onChanged,
              onTap: onTap,
            ),
          ),

          if (suffixIcon != null)
            Padding(
              padding: EdgeInsets.only(left: cw(8)),
              child: suffixIcon,
            ),
        ],
      ),
    ),
  );
}
