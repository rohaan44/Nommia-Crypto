import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nommia_crypto/utils/asset_utils.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:sizer/sizer.dart';

class TradeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const TradeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12.h,
      width: 100.w,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Bottom Bar
          Positioned(
            bottom: 0,
            child: Container(
              height: 10.h,
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(color: AppColor.cardDark),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _item(icon: AssetUtils.tradeIcon, label: "Trade", index: 0),
                  _item(
                    icon: AssetUtils.marketIcon,
                    label: "Markets",
                    index: 1,
                  ),
                  SizedBox(width: 18.w),
                  _item(icon: AssetUtils.socialIcon, label: "Social", index: 3),
                  _item(
                    icon: AssetUtils.accountIcon,
                    label: "Accounts",
                    index: 4,
                  ),
                ],
              ),
            ),
          ),

          // Center Floating Button
          Positioned(
            bottom: 4.5.h,
            child: GestureDetector(
              onTap: () => onTap(2),
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppColor.cardDark,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 6.w,
                  backgroundColor: currentIndex == 2
                      ? AppColor.gold
                      : AppColor.darkGrey,
                  child: SvgPicture.asset(
                    AssetUtils.nomaniaIcon,
                    width: 23.sp,
                    height: 23.sp,
                    colorFilter: ColorFilter.mode(
                      currentIndex == 2 ? AppColor.black : AppColor.gold,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item({
    required String icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 20.sp,
            height: 20.sp,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColor.gold : AppColor.grey,
              BlendMode.srcIn, // fixes SVG hardcoded color issue
            ),
          ),
          SizedBox(height: 0.4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 8.5.sp,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColor.gold : AppColor.grey,
            ),
          ),
        ],
      ),
    );
  }
}
