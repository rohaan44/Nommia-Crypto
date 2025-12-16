import 'package:flutter/material.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/account_screen_2/profile_controller.dart';
import 'package:nommia_crypto/ui_molecules/app_primary_button.dart';
import 'package:nommia_crypto/utils/asset_utils.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/utils/font_size.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileController(),
      child: Scaffold(
        backgroundColor: AppColor.primaryBackground,
        body: Consumer<ProfileController>(
          builder: (context, controller, child) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildAccountSelector(controller),
                    const SizedBox(height: 30),
                    _buildAccountStats(),
                    const SizedBox(height: 30),
                    _buildTabs(controller),
                    const SizedBox(height: 10),
                    Expanded(child: _buildTradeList(controller)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAccountSelector(ProfileController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            txt: controller.selectedAccount,
            color: AppColor.textGrey,
            fontSize: 16,
          ),
          const Icon(Icons.keyboard_arrow_down, color: AppColor.white),
        ],
      ),
    );
  }

  Widget _buildAccountStats() {
    return Column(
      children: [
        AppText(txt: "Current P&L", color: AppColor.textGrey, fontSize: 14),
        const SizedBox(height: 8),
        AppText(
          txt: "\$1,200.00",
          color: AppColor.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(txt: "Equity", color: AppColor.textGrey, fontSize: 14),
            const SizedBox(width: 8),
            AppText(
              txt: "\$13,700.00",
              color: AppColor.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabs(ProfileController controller) {
    return Container(
      height: 45,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          _buildTabItem(controller, "Open"),
          _buildTabItem(controller, "Pending"),
          _buildTabItem(controller, "Closed"),
        ],
      ),
    );
  }

  Widget _buildTabItem(ProfileController controller, String label) {
    bool isSelected = controller.selectedTab == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setTab(label),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColor.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: AppText(
            txt: label,
            color: isSelected ? Colors.black : AppColor.textGrey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildTradeList(ProfileController controller) {
    return ListView.builder(
      itemCount: controller.trades.length,
      itemBuilder: (context, index) {
        final trade = controller.trades[index];
        return GestureDetector(
          onTap: () => _showTradeDetailSheet(context, trade, controller),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border(
                bottom: BorderSide(color: AppColor.divider.withOpacity(0.1)),
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.orange, // Bitcoin icon placeholder color
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.currency_bitcoin,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AppText(
                                txt: trade.symbol,
                                color: AppColor.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              const SizedBox(width: 8),
                              _buildSideBadge(trade.type),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.star,
                                color: AppColor.accentYellow,
                                size: 16,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    txt: trade.type == "BUY"
                                        ? "Open Time"
                                        : "Close Time", // Example logic
                                    color: AppColor.textGrey,
                                    fontSize: 10,
                                  ),
                                  const SizedBox(height: 2),
                                  AppText(
                                    txt: trade.time,
                                    color: AppColor.white,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  AppText(
                                    txt: "Volume",
                                    color: AppColor.textGrey,
                                    fontSize: 10,
                                  ),
                                  const SizedBox(height: 2),
                                  AppText(
                                    txt: trade.volume.toStringAsFixed(2),
                                    color: AppColor.white,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppText(
                          txt: trade.profit.toString(),
                          color: trade.isLoss
                              ? AppColor.sellRed
                              : AppColor.buyGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AppText(
                              txt: trade.type == "BUY"
                                  ? "Open Price"
                                  : "Close Price",
                              color: AppColor.textGrey,
                              fontSize: 10,
                            ),
                            const SizedBox(height: 2),
                            AppText(
                              txt: trade.openPrice.toString(),
                              color: AppColor.white,
                              fontSize: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSideBadge(String type) {
    Color color = type == "BUY" ? AppColor.buyGreen : AppColor.sellRed;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: AppText(
        txt: type,
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _showTradeDetailSheet(
    BuildContext context,
    TradeItem trade,
    ProfileController controller, {
    bool isDeleteMode = false,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.cardBackground,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.currency_bitcoin,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // AppText(
                      //   txt: trade.symbol,
                      //   color: AppColor.white,
                      //   fontSize: 18,
                      //   fontWeight: FontWeight.bold,
                      // ),
                      AppText(
                        txt: trade.symbol,
                        color: AppColor.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(width: 8),
                      _buildSideBadge(trade.type),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColor.textGrey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  txt: "Detail of: W89313263291314", // Mock ID
                  color: AppColor.textGrey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: AppColor.divider),
              // Detail Grid (3x4 approx)
              _buildDetailGrid(trade),
              const SizedBox(height: 20),
              const Divider(color: AppColor.divider),
              const SizedBox(height: 20),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.accentYellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {}, // Modify placeholder
                        child: AppText(
                          txt: "Modify",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.sellRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          if (isDeleteMode) {
                            // "Cancel" action -> Delete Trade
                            Navigator.pop(context); // Close sheet
                            controller.removeTrade(trade);
                          } else {
                            // "Close" action -> Show Warning
                            Navigator.pop(context); // Close current sheet
                            _showCloseWarningDialog(context, trade, controller);
                          }
                        },
                        child: AppText(
                          txt: isDeleteMode ? "Cancel" : "Close",
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailGrid(TradeItem trade) {
    return Column(
      children: [
        _buildDetailRow(
          "Volume",
          trade.volume.toStringAsFixed(2),
          "Close Price",
          "1.33180",
          "Profit",
          "-558.57",
          val3Color: AppColor.sellRed,
        ),
        const Divider(color: AppColor.divider),
        _buildDetailRow(
          "Open Price",
          trade.openPrice.toString(),
          "Open Time",
          trade.time,
          "",
          "",
        ),
        const Divider(color: AppColor.divider),
        _buildDetailRow(
          "Stop Loss",
          "1.33182",
          "Take Profit",
          "1.37839",
          "",
          "",
        ),
        const Divider(color: AppColor.divider),
        _buildDetailRow(
          "Swap",
          "- 69.90",
          "Close Time",
          "09/10/2025. 15:09:23",
          "",
          "",
        ),
        const Divider(color: AppColor.divider),
        _buildDetailRow(
          "Commission",
          "-2.67",
          "Reason",
          "SL",
          "",
          "",
          val1Color: AppColor.sellRed,
          val2Color: AppColor.sellRed,
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    String l1,
    String v1,
    String l2,
    String v2,
    String l3,
    String v3, {
    Color? val1Color,
    Color? val2Color,
    Color? val3Color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (l1.isNotEmpty)
                  AppText(txt: l1, color: AppColor.textGrey, fontSize: 12),
                if (v1.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  AppText(
                    txt: v1,
                    color: val1Color ?? AppColor.white,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            flex: 2, // Give more space to middle/time columns
            child: Container(
              padding: EdgeInsets.only(left: 20), // Add left padding
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: AppColor.divider)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (l2.isNotEmpty)
                    AppText(txt: l2, color: AppColor.textGrey, fontSize: 12),
                  if (v2.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    AppText(
                      txt: v2,
                      color: val2Color ?? AppColor.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (l3.isNotEmpty)
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: AppColor.divider)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(txt: l3, color: AppColor.textGrey, fontSize: 12),
                    const SizedBox(height: 4),
                    AppText(
                      txt: v3,
                      color: val3Color ?? AppColor.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showCloseWarningDialog(
    BuildContext context,
    TradeItem trade,
    ProfileController controller,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor.cardBackground,
          icon: Image.asset(AssetUtils.tradeCancelImg, width: 100, height: 50),
          title: AppText(
            textAlign: TextAlign.center,
            txt: "Confirm Close Trade",
            color: AppColor.white,
            fontWeight: FontWeight.w400,
            fontSize: AppFontSize.f18,
          ),
          content: AppText(
            textAlign: TextAlign.center,
            txt:
                "Are you sure you want to close this active trade?\nThis action cannot be undone.",
            color: AppColor.textGrey,
            height: 1.5,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColor.textGrey),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22),
                      child: AppText(txt: "Cancel", color: AppColor.textGrey),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: AppButton(
                    onPressed: () {
                      Navigator.pop(context); // Close Dialog
                      // Re-open Sheet in Delete Mode
                      _showTradeDetailSheet(
                        context,
                        trade,
                        controller,
                        isDeleteMode: true,
                      );
                    },
                    child: AppText(
                      txt: "Confirm",
                      color: AppColor.background,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
