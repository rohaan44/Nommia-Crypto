import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/utils/asset_utils.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';

class DropdownBottomSheet extends StatelessWidget {
  final String title;
  final String? selectedValue;
  final double? height;
  final List<String> items;
  final Function(String) onSelect;

  const DropdownBottomSheet({
    super.key,
    required this.title,
    required this.items,
    required this.onSelect,
    this.selectedValue,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openSheet(context),
      child: Container(
        width: 500,
        height: height ?? ch(46),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColor.c0C1010,
          borderRadius: BorderRadius.circular(cw(11)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                txt: selectedValue ?? title,
                fontSize: AppFontSize.f14,
                fontWeight: FontWeight.w500,
                color: selectedValue == null
                    ? AppColor.cFFFFFF.withOpacity(0.6)
                    : AppColor.cFFFFFF,
              ),

              SvgPicture.asset(AssetUtils.downIcon),
              // const Icon(Icons.keyboard_arrow_down_rounded, size: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _openSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.fieldBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: items.map((item) {
            return ListTile(
              title: AppText(
                txt: item.toString(),
                fontSize: AppFontSize.f14,
                fontWeight: FontWeight.w500,
                color: AppColor.cFFFFFF,
              ),
              onTap: () {
                Navigator.pop(context);
                onSelect(item);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
