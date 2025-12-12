// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/market_screen/sub_widgets/tab_widgets.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/primary_textfield.dart';
import 'package:nommia_crypto/utils/asset_utils.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/theme/app_gradient.dart';
import 'package:sizer/sizer.dart';

class MarketScreen extends StatefulWidget {
  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 🔥 Aapki dynamic list
  final List<String> tabs = [
    "All",
    "Favourite",
    "Majors",
    "Minors",
    "Settings",
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ch(130)), // jitni height chahiye
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: AppGradients.bgGradient),
            child: Column(
              children: [
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: cw(24)),
                  child: Row(
                    children: [
                      Expanded(
                        child: primaryTextField(
                          fillColor: AppColor.fieldBg,
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColor.cFFFFFF,
                            size: 18,
                          ),
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
                        ),
                      ),
                    ],
                  ),
                ),

                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: AppColor.cFFFFFF,
                    unselectedLabelColor: Colors.white54,
                    indicatorColor: AppColor.cFFFFFF,
                    indicatorWeight: 2,
                    dividerColor: AppColor.c1F242A,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.symmetric(horizontal: cw(25)),
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    tabs: tabs.map((e) => Tab(text: e)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(gradient: AppGradients.bgGradient),
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    allMarketList(),
                    favouriteMarketList(),
                    allMarketList(), // Majors (dummy)
                    allMarketList(), // Minors (dummy)
                    allMarketList(), // Etc...
                  ],

                  //  tabs.map((e) {
                  //   return Center(child: Text("$e Screen"));
                  // }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
