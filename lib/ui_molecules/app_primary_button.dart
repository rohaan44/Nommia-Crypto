import 'package:flutter/material.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';
import 'package:nommia_crypto/utils/theme/app_gradient.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    this.text,
    this.textColor,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.isLoading = false,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.buttonStyle,
    this.textDecoration,
    this.color,
    this.buttonColor,
    this.isBorder = true,
    this.borderColor,
    this.borderWidth = 0.5,
    this.isButtonEnable = true,
    this.borderRadius,
    this.fromAuthScreen,
    this.textHeight,
    this.isRow = false,
    this.svg,
    this.boxShadow,
    this.showIcon = false,
    this.icon,
    this.iconSpacing = 8.0,
    this.gradient,
  });

  final String? text;
  final Color? textColor;
  final Widget? child;
  final List<BoxShadow>? boxShadow;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final double? fontSize;
  final FontWeight? fontWeight;
  final BoxDecoration? buttonStyle;
  final bool isLoading;
  final TextDecoration? textDecoration;
  final Color? color;
  final Color? buttonColor;
  final bool isBorder;
  final Color? borderColor;
  final double borderWidth;
  final bool isButtonEnable;
  final double? borderRadius;
  final double? textHeight;
  final bool isRow;
  final Widget? svg;
  final bool? fromAuthScreen;

  // 🔹 Icon support
  final bool showIcon;
  final Widget? icon;
  final double iconSpacing;

  // 🔹 New: Gradient Support
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final bool applyGradient = isButtonEnable && gradient != null;

    return InkWell(
      onTap: isLoading || !isButtonEnable
          ? null
          : () {
              FocusManager.instance.primaryFocus?.unfocus();
              onPressed();
            },
      child: Container(
        alignment: Alignment.center,
        padding: padding ?? EdgeInsets.zero,
        width: width ?? double.infinity,
        height: height ?? ch(51),

        decoration:
            buttonStyle ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? cw(50)),

              // ➤ APPLY GRADIENT ONLY IF BUTTON IS ENABLED
              gradient: isButtonEnable == true
                  ? AppGradients.goldenBtn
                  : applyGradient
                  ? gradient
                  : null,

              // ➤ IF GRADIENT ENABLED → no solid color
              // ➤ IF GRADIENT DISABLED → use buttonColor
              color: applyGradient ? null : (buttonColor ?? AppColor.fieldBg),

              border: applyGradient
                  ? null
                  : isBorder
                  ? Border.all(
                      color: (borderColor ?? AppColor.cFFFFFF),
                      width: borderWidth,
                    )
                  : null,
            ),

        child:
            child ??
            (!isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (showIcon && icon != null) ...[
                        icon!,
                        if (text != null) SizedBox(width: iconSpacing),
                      ],

                      if (text != null)
                        AppText(
                          txt: text!,
                          fontSize: fontSize ?? AppFontSize.f15 - 2,
                          color: isButtonEnable
                              ? (textColor ?? AppColor.background)
                              : AppColor.cFFFFFF,
                          fontWeight: fontWeight ?? FontWeight.w500,
                          decoration: textDecoration ?? TextDecoration.none,
                          // letterSpacing: 0,
                          height: textHeight,
                        ),

                      if (isRow && svg != null) ...[const Spacer(), svg!],
                    ],
                  )
                : const CircularProgressIndicator(color: AppColor.white)),
      ),
    );
  }
}
