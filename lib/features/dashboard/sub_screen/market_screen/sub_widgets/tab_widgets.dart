import 'package:flutter/material.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/market_screen/market_screen.controller.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/utils/color_utils.dart';

Widget marketHeader() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
    decoration: BoxDecoration(color: AppColor.transparent),
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

TextStyle headerStyle() =>
    TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 12);
Widget marketRow(MarketItem item) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    margin: EdgeInsets.only(bottom: 2),
    decoration: BoxDecoration(color: AppColor.transparent),
    child: Row(
      children: [
        /// ⭐ + pair
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Icon(
                item.isFav ? Icons.star : Icons.star_border,
                size: 18,
                color: item.isFav ? Colors.yellow : Colors.grey,
              ),
              SizedBox(width: 8),
              Text(
                item.pair,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),

        /// Bid
        Expanded(
          flex: 2,
          child: Text(
            item.bid,
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),

        /// Ask
        Expanded(
          flex: 2,
          child: Text(
            item.ask,
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),

        /// Change (green/red)
        Expanded(
          flex: 2,
          child: Text(
            "${item.change.toStringAsFixed(2)}%",
            style: TextStyle(
              color: item.change >= 0 ? Colors.green : Colors.red,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget allMarketList() {
  return Column(
    children: [
      marketHeader(),
      // Expanded(
      //   child: ListView.builder(
      //     itemCount: marketList.length,
      //     itemBuilder: (_, i) => marketRow(marketList[i]),
      //   ),
      // ),
      Expanded(
        child: ListView.separated(
          itemBuilder: (_, i) => marketRow(marketList[i]),
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: cw(24)),
            child: Divider(color: AppColor.c1F242A),
          ),
          itemCount: marketList.length,
        ),
      ),
    ],
  );
}

Widget favouriteMarketList() {
  final favs = marketList.where((e) => e.isFav).toList();

  return Column(
    children: [
      marketHeader(),

      Expanded(
        child: ListView.separated(
          itemBuilder: (_, i) => marketRow(favs[i]),
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: cw(24)),
            child: Divider(color: AppColor.c1F242A),
          ),
          itemCount: favs.length,
        ),
      ),
    ],
  );
}
