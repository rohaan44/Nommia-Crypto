import 'package:flutter/material.dart';
import 'package:nommia_crypto/features/bottom_navbar/bottom_navbar.dart';
import 'package:nommia_crypto/features/dashboard/home_screen_controller.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/account_screen/account_screen.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/custom_appbar.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});

  @override
  // ignore: override_on_non_overriding_member
  final screenList = [
    Container(height: 100.h, color: AppColor.white),
    Container(height: 100.h, color: AppColor.red),
    Container(height: 100.h, color: AppColor.white),
    Container(height: 100.h, color: AppColor.cardDark),
    AccountScreen(),
  ];
  Widget build(BuildContext context) {
    return Consumer<DashBoardScreenController>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(ch(100)),
            child: customAppBar(
              context: context,
              model: model,

              searchFieldController: model.searchFieldController,
            ),
          ),
          bottomNavigationBar: TradeBottomNavBar(
            currentIndex: model.selectedIndex,
            onTap: (index) => model.onBottomNavTap(index),
          ),
          body: SingleChildScrollView(child: screenList[model.selectedIndex]),
        );
      },
    );
  }
}
