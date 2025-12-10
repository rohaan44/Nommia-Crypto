import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/primary_textfield.dart';
import 'package:nommia_crypto/utils/asset_utils.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/theme/app_gradient.dart';

Widget customAppBar({
  required BuildContext context,
  required model,
  required TextEditingController searchFieldController,
}) {
  return Container(
    decoration: BoxDecoration(gradient: AppGradients.bgGradient),
    padding: EdgeInsets.fromLTRB(cw(23), ch(50), cw(15), ch(23)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: primaryTextField(
              fillColor: AppColor.fieldBg,
              prefixIcon: Icon(Icons.search, color: AppColor.cFFFFFF, size: 18),
              textStyle: TextStyle(fontSize: 13),
              hintText: "Search pairs ...",
              hintStyle: TextStyle(
                fontSize: 13,
                color: AppColor.cFFFFFF,
                fontWeight: FontWeight.w500,
              ),
              borderRadius: 22,
              borderColor: AppColor.transparent,

              border: InputBorder.none,
            ),
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
              image: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTk_CtsORNDIpac7yGO8reKJQQ6zxVfthyqmQ&s",
              ),
              fit: BoxFit.cover,
            ),
            color: AppColor.red,
          ),
        ),
      ],
    ),
  );
}
