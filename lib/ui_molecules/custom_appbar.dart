import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/primary_textfield.dart';
import 'package:nommia_crypto/utils/asset_utils.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';
import 'package:nommia_crypto/utils/theme/app_gradient.dart';

PreferredSizeWidget customAppBar({
  required BuildContext context,
  required model,
  required TextEditingController searchFieldController,
  double height = 95,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(ch(height)), // 👈 REQUIRED
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppGradients.bgGradient,
      ),
      padding: EdgeInsets.fromLTRB(
        cw(23),
        ch(50),
        cw(15),
        ch(23),
      ),
      child: Row(
        children: [
          Expanded(
            child: primaryTextField(
              controller: searchFieldController,
              prefixIcon: SvgPicture.asset(AssetUtils.searchIcon),
              textStyle: const TextStyle(fontSize: 13),
              hintText: "Search pairs ...",
              hintStyle: TextStyle(
                fontSize: AppFontSize.f13,
                fontWeight: FontWeight.w500,
                color: AppColor.cFFFFFF.withOpacity(0.5),
              ),
              borderRadius: 22,
              borderColor: AppColor.transparent,
              border: InputBorder.none,
            ),
          ),
          SizedBox(width: cw(12)),
          SvgPicture.asset(AssetUtils.notifications),
          SizedBox(width: cw(12)),
          Container(
            height: ch(42),
            width: cw(42),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(AssetUtils.profileImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
