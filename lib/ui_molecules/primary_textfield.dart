import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';

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
  final fieldHeight = textFieldHeight ?? ch(46);
  final isTall = fieldHeight > ch(60);

  return Container(
    height: fieldHeight,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(cw(borderRadius ?? 14)),
      border: Border.all(color: AppColor.c0C1010),
      color: fillColor ?? AppColor.c0C1010,
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: cw(16)),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: AppColor.red,
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly,
        autofocus: autoFocus,
        obscureText: obscureText,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        style:
            textStyle ??
            TextStyle(
              color: AppColor.white,
              fontSize: AppFontSize.f16,
              fontWeight: FontWeight.w500,
            ),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: fillColor ?? AppColor.c0C1010,
          border:
              border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(cw(borderRadius ?? 14)),
                borderSide: BorderSide(color: AppColor.white, width: cw(1)),
              ),
          enabledBorder:
              border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(cw(borderRadius ?? 14)),
                borderSide: BorderSide(color: AppColor.white, width: cw(1)),
              ),
          focusedBorder:
              border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(cw(borderRadius ?? 14)),
                borderSide: BorderSide(
                  color: isBorderColor
                      ? borderColor ?? AppColor.green
                      : AppColor.green,
                  width: cw(1),
                ),
              ),
          hintText: hintText,
          hintStyle:
              hintStyle ??
              TextStyle(
                fontSize: AppFontSize.f15,
                fontWeight: FontWeight.w400,
                color: AppColor.cFFFFFF.withOpacity(0.5),
              ),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: EdgeInsets.only(right: cw(8)),
                  child: prefixIcon,
                )
              : null,
          prefixIconConstraints: prefixIcon != null
              ? BoxConstraints(minWidth: cw(24), minHeight: ch(24))
              : null,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: EdgeInsets.only(left: cw(8)),
                  child: suffixIcon,
                )
              : null,
          suffixIconConstraints: suffixIcon != null
              ? BoxConstraints(minWidth: cw(24), minHeight: ch(24))
              : null,
          contentPadding: EdgeInsets.symmetric(
            vertical: isTall ? ch(10) : ch(2),
          ),
          isDense: true,
        ),
        onChanged: onChanged,
        onTap: onTap,
      ),
    ),
  );
}
