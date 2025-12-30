import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
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
            bottom: 0.2.h,
            child: GestureDetector(
              onTap: () => onTap(2),
              child: ClipPath(
                clipper: HouseClipper(),
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  width: 100,
                  height: ch(100),
                  color: AppColor.cardDark,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                              AssetUtils.nomaniaIcon,
                              width:35.sp,
                              height: 35.sp,
                              colorFilter: ColorFilter.mode(
                                currentIndex == 2 ? AppColor.gold : AppColor.grey,
                                BlendMode.srcIn,
                              ),
                        ),
                        Spacer(),
                      AppText(txt: "Home" ,
                   fontSize: 8.5.sp,
              fontWeight: FontWeight.w500,
                      color: currentIndex == 2  ? AppColor.gold : AppColor.grey,),
                      SizedBox(height: ch(20)),
                    ],
                  ),
              )
              // GestureDetector(
              //   onTap: () => onTap(2),
              //   child: Column(
              //     children: [
              //       SizedBox(height: 20,),
              //       Container(
              //         padding: EdgeInsets.all(2.w),
              //         decoration: BoxDecoration(
              //           color: AppColor.cardDark,
              //           shape: BoxShape.circle,
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.black.withOpacity(0.35),
              //               blurRadius: 12,
              //               offset: const Offset(0, 4),
              //             ),
              //           ],
              //         ),
              //         child: CircleAvatar(
              //           radius: 6.w,
              //           backgroundColor: currentIndex == 2
              //               ? AppColor.gold
              //               : AppColor.darkGrey,
              //           child: SvgPicture.asset(
              //             AssetUtils.nomaniaIcon,
              //             width: 23.sp,
              //             height: 23.sp,
              //             colorFilter: ColorFilter.mode(
              //               currentIndex == 2 ? AppColor.black : AppColor.gold,
              //               BlendMode.srcIn,
              //             ),
              //           ),
              //         ),
              //       ),
                    
              //       AppText(txt: "Home")
              //     ],
              //   ),
              // ),
                        ),
            ),
       ) ],
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
              fontWeight: FontWeight.w500,
              color: isSelected ? AppColor.gold : AppColor.grey,
            ),
          ),
        ],
      ),
    );
  }
}
class HouseClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width / 2, size.height * 0.02);          // roof peak
    path.lineTo(size.width, size.height * .2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * .2);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
