import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/market_screen/market_screen.controller.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/market_screen/sub_widgets/tab_widgets.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/primary_textfield.dart';
import 'package:nommia_crypto/utils/asset_utils.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/theme/app_gradient.dart';

class MarketScreen extends StatefulWidget {
  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
    return ChangeNotifierProvider(
      create: (_) => MarketScreenController(),
      child: Consumer<MarketScreenController>(
        builder: (context, controller, _) {
          return Scaffold(
            extendBodyBehindAppBar: true,

            appBar: PreferredSize(
              preferredSize: Size.fromHeight(ch(130)),
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
                                hintText: "Search pairs ...",
                                borderRadius: 22,
                                border: InputBorder.none,
                              ),
                            ),
                            SizedBox(width: cw(12)),
                            SvgPicture.asset(AssetUtils.notifications),
                            SizedBox(width: cw(12)),
                            CircleAvatar(
                              radius: ch(21),
                              backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTk_CtsORNDIpac7yGO8reKJQQ6zxVfthyqmQ&s",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                          dividerColor: AppColor.c1F242A,
                          labelPadding: EdgeInsets.only(right: cw(50)),
                          controller: _tabController,
                          isScrollable: true,
                          tabs: tabs.map((e) => Tab(text: e)).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// 🔥 BODY
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(gradient: AppGradients.bgGradient),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    allMarketList(controller, context),
                    favouriteMarketList(controller, context),
                    allMarketList(controller, context),
                    allMarketList(controller, context),
                    allMarketList(controller, context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
