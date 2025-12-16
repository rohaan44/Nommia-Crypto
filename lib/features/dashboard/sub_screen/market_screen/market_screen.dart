import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nommia_crypto/ui_molecules/custom_appbar.dart';
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
            appBar: customAppBar(
              height: 130,
              context: context,
              model: controller,
              searchFieldController: TextEditingController(),
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
