import 'package:flutter/material.dart';
import 'package:nommia_crypto/features/dashboard/home_screen_controller.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/market_screen/market_screen.controller.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';
import 'package:provider/provider.dart';

Widget marketHeader() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: cw(24), vertical: ch(10)),
    child: Row(
      children: [
        Expanded(flex: 4, child: Text("Assets", style: headerStyle())),
        Expanded(flex: 2, child: Text("Bid", style: headerStyle())),
        Expanded(flex: 2, child: Text("Ask", style: headerStyle())),
        Expanded(flex: 2, child: Text("Change", style: headerStyle())),
      ],
    ),
  );
}

TextStyle headerStyle() => TextStyle(
  color: AppColor.cFFFFFF,
  fontWeight: FontWeight.w500,
  fontSize: AppFontSize.f11,
);

Widget marketRow(BuildContext context, MarketItem item, VoidCallback onFavTap) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      final controller = context.read<DashBoardScreenController>();
      controller.onBottomNavTap(0);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                GestureDetector(
                  onTap: onFavTap,
                  child: Icon(
                    item.isFav ? Icons.star : Icons.star_border,
                    size: 25,
                    color: item.isFav ? Colors.yellow : Colors.grey,
                  ),
                ),
                SizedBox(width: cw(12)),
                AppText(
                  txt: item.pair,
                  color: Colors.white,
                  fontSize: AppFontSize.f14,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: AppText(
              txt: item.bid,
              color: AppColor.cFFFFFF,
              fontSize: AppFontSize.f12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            flex: 2,
            child: AppText(
              txt: item.ask,
              color: AppColor.cFFFFFF,
              fontSize: AppFontSize.f12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            flex: 2,
            child: AppText(
              txt:
                  "${item.change >= 0 ? '+' : ''}${item.change.toStringAsFixed(2)}%",
              color: item.change >= 0 ? Colors.green : Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget allMarketList(MarketScreenController controller, BuildContext context) {
  return Column(
    children: [
      marketHeader(),
      Expanded(
        child: ListView.separated(
          itemCount: controller.allItems.length,
          itemBuilder: (_, i) => marketRow(
            context,
            controller.allItems[i],
            () => controller.toggleFavourite(controller.allItems[i]),
          ),
          separatorBuilder: (_, __) => Divider(color: AppColor.c1F242A),
        ),
      ),
    ],
  );
}

Widget favouriteMarketList(
  MarketScreenController controller,
  BuildContext context,
) {
  return Column(
    children: [
      marketHeader(),
      Expanded(
        child: ListView.separated(
          itemCount: controller.favouriteItems.length,
          itemBuilder: (_, i) => marketRow(
            context,
            controller.favouriteItems[i],
            () => controller.toggleFavourite(controller.favouriteItems[i]),
          ),
          separatorBuilder: (_, __) => Divider(color: AppColor.c1F242A),
        ),
      ),
    ],
  );
}
