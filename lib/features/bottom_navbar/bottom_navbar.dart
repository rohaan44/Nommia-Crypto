import 'package:flutter/material.dart';
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
          // Bottom Bar Background
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
                  _item(icon: Icons.public, label: "Trade", index: 0),
                  _item(
                    icon: Icons.stacked_line_chart,
                    label: "Markets",
                    index: 1,
                  ),
                  SizedBox(width: 18.w),
                  _item(icon: Icons.style, label: "Social", index: 3),
                  _item(icon: Icons.person, label: "Accounts", index: 4),
                ],
              ),
            ),
          ),

          // CENTER FLOATING BUTTON
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
                  child: Icon(
                    Icons.home_max_outlined,
                    color: currentIndex == 2
                        ? AppColor.black
                        : AppColor.lightGrey,
                    size: 23.sp,
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
    required IconData icon,
    required String label,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: currentIndex == index ? AppColor.gold : AppColor.grey,
          ),
          SizedBox(height: 0.4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 8.5.sp,
              fontWeight: FontWeight.w600,
              color: currentIndex == index ? AppColor.gold : AppColor.grey,
            ),
          ),
        ],
      ),
    );
  }
}
