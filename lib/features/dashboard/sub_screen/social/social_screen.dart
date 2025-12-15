import 'package:flutter/material.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/social/social_controller.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/ui_molecules/bottom_sheets/create_account_bottomsheet.dart';
import 'package:nommia_crypto/ui_molecules/primary_textfield.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SocialController(),
      child: Scaffold(
        backgroundColor: AppColor.primaryBackground,
        body: Consumer<SocialController>(
          builder: (context, controller, child) {
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          _buildSectionTitle("Trade Ideas"),
                          const SizedBox(height: 12),
                          _buildTradeIdeaList(controller),
                          const SizedBox(height: 24),
                          _buildSectionTitle("Copy Trading"),
                          const SizedBox(height: 12),
                          _buildStrategyList(context, controller.copyTraders),
                          const SizedBox(height: 24),
                          _buildSectionTitle("Pamm Accounts"),
                          const SizedBox(height: 12),
                          _buildStrategyList(context, controller.pammAccounts),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return AppText(
      txt: title,
      color: AppColor.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );
  }

  Widget _buildTradeIdeaList(SocialController controller) {
    return SizedBox(
      height: 170, // Adjusted height for square-ish cards
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.tradeIdeas.length,
        itemBuilder: (context, index) {
          final idea = controller.tradeIdeas[index];
          return InkWell(
            onTap: () {
              showSignalDetailBottomSheet(context);
            },
            child: Container(
              width: 150,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.cardBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        txt: "Asset Class",
                        color: AppColor.textGrey,
                        fontSize: 10,
                      ),
                      const SizedBox(height: 4),
                      AppText(
                        txt: idea.assetClass,
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      const SizedBox(height: 12),
                      AppText(
                        txt: "Asset Name",
                        color: AppColor.textGrey,
                        fontSize: 10,
                      ),
                      const SizedBox(height: 4),
                      AppText(
                        txt: idea.assetName,
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.grey,
                        // backgroundImage: ... if available
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AppText(
                          txt: idea.author,
                          color: AppColor.textGrey,
                          fontSize: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStrategyList(
    BuildContext context,
    List<SocialStrategy> strategies,
  ) {
    return SizedBox(
      height: 340, // Height for detailed strategy cards
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: strategies.length,
        itemBuilder: (context, index) {
          return _buildStrategyCard(context, strategies[index]);
        },
      ),
    );
  }

  Widget _buildStrategyCard(BuildContext context, SocialStrategy strategy) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(20),
        // Add a subtle gradient or border if needed to match "Premium" look
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: strategy.isSubscribed
                  ? Colors
                        .red // Using standard red matching mockup
                  : Colors.grey.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              strategy.isSubscribed ? "SUBSCRIBED" : "UNSUBSCRIBED",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40), // Spacing for chart visual area
          // Strategy Name
          AppText(txt: "Strategy Name", color: AppColor.textGrey, fontSize: 12),
          const SizedBox(height: 4),
          AppText(
            txt: strategy.name,
            color: AppColor.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          // Stats Grid
          Row(
            children: [
              _buildStatItem("ROI", strategy.roi, color: AppColor.buyGreen),
              const Spacer(),
              _buildStatItem("Capital", strategy.capital),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatItem("Fee (Trader/Client)", strategy.fee),
              const Spacer(),
              _buildStatItem("Min. Deposit", strategy.minDeposit),
            ],
          ),
          const Spacer(),
          // Actions
          if (strategy.isSubscribed)
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: OutlinedButton(
                      onPressed: () => _showWithdrawFundsBottomSheet(context),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColor.accentYellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: BorderSide.none,
                      ),
                      child: const Text(
                        "- Funds",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: OutlinedButton(
                      onPressed: () => _showAddFundsBottomSheet(context),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColor.accentYellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: BorderSide.none,
                      ),
                      child: const Text(
                        "+ Funds",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            SizedBox(
              height: 40,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () =>
                    _showCopyStrategyBottomSheet(context, strategy),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColor.accentYellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: BorderSide.none,
                ),
                child: const Text(
                  "Copy",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value, {
    Color color = Colors.white,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(txt: label, color: AppColor.textGrey, fontSize: 10),
        const SizedBox(height: 2),
        AppText(
          txt: value,
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }

  // --- BOTTOM SHEETS (Reused logic with slight tweaks if needed) ---

  void _showCopyStrategyBottomSheet(
    BuildContext context,
    SocialStrategy strategy,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return createAccountBottomesheet(
          context: context,
          isDivider: false,
          description: "Please choose your parameters.",
          heading: "Start Copying Trading Activity",
          title1: "Copy Type",
          title2: "Amount (USD)",
          hint1: "Select Copy Type",
          hint2: "Enter Amount (USD)",
          isDropDown: true,
          primarybtnHandler: () {},
          secondarybtnHandler: () {},
          secondarybtnText: "Okay",
          primarybtnText: "Cancel",
        );
      },
    );
  }

  void _showAddFundsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xff1E2026),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AppText(
                  txt: "Add Funds",
                  color: AppColor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              _buildLabel("Trading Account"),
              const SizedBox(height: 8),
              _buildReadOnlyField("Account Name"),
              const SizedBox(height: 16),
              _buildLabel("Total Allocated Funds (USD)"),
              const SizedBox(height: 8),
              _buildReadOnlyField("\$"),
              const SizedBox(height: 16),
              _buildLabel("Amount (USD)"),
              const SizedBox(height: 8),
              _buildReadOnlyField("\$"),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColor.textGrey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: AppText(
                        txt: "Cancel",
                        color: AppColor.textGrey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.accentYellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: AppText(
                        txt: "OK",
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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

  void _showWithdrawFundsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xff1E2026),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AppText(
                  textAlign: TextAlign.start,
                  txt: "Withdraw Funds",
                  color: AppColor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              _buildLabel("Trading Account"),
              const SizedBox(height: 8),
              _buildReadOnlyField("Account Name"),
              const SizedBox(height: 16),
              _buildLabel("Total Allocated Funds (USD)"),
              const SizedBox(height: 8),
              _buildReadOnlyField("\$"),
              const SizedBox(height: 16),
              _buildLabel("Amount (USD)"),
              const SizedBox(height: 8),
              _buildReadOnlyField("\$"),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColor.textGrey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: AppText(
                        txt: "Cancel",
                        color: AppColor.textGrey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.accentYellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: AppText(
                        txt: "OK",
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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

  Widget _buildLabel(String text) {
    return AppText(txt: text, color: AppColor.textGrey, fontSize: 14);
  }

  Widget _buildReadOnlyField(String text) {
    return primaryTextField(hintText: text);
  }

  //   Widget _buildInputField(String hint) {
  //     return Container(
  //       width: double.infinity,
  //       padding: const EdgeInsets.symmetric(horizontal: 16),
  //       decoration: BoxDecoration(
  //         color: const Color(0xff121418), // Darker input bg
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: TextField(
  //         style: const TextStyle(color: Colors.white),
  //         decoration: InputDecoration(
  //           border: InputBorder.none,
  //           hintText: hint,
  //           hintStyle: const TextStyle(color: AppColor.textGrey),
  //         ),
  //       ),
  //     );
  //   }
  // }

  void showSignalDetailBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.92,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          builder: (context, controller) {
            return Container(
              decoration: BoxDecoration(
                color: AppColor.c0C1010,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(cw(22)),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Banner Image
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(22),
                              topRight: Radius.circular(22),
                            ),
                            child: Image.network(
                              "https://img.freepik.com/free-photo/day-trader-uses-computer-purchase-stocks-that-might-perform-well_482257-126398.jpg?semt=ais_hybrid&w=740&q=80",
                              height: ch(190),
                              width: 100.w,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: cw(24)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: ch(24)),

                                /// Title
                                Text(
                                  "Bullish Reversal at Key Support",
                                  style: TextStyle(
                                    fontSize: AppFontSize.f16,
                                    color: AppColor.cFFFFFF,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                SizedBox(height: ch(31)),

                                /// Author Row
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: cw(18),
                                      backgroundImage: NetworkImage(
                                        "https://randomuser.me/api/portraits/men/32.jpg",
                                      ),
                                    ),
                                    SizedBox(width: cw(10)),
                                    Row(
                                      children: [
                                        Text(
                                          "Andrej V.",
                                          style: TextStyle(
                                            color: AppColor.cFFFFFF,
                                            fontSize: AppFontSize.f12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: cw(28.9)),
                                        Text(
                                          "11 Nov 2025",
                                          style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: AppFontSize.f13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: ch(26)),
                                Divider(color: Colors.white12),

                                /// Asset Class + Name
                                SizedBox(height: ch(23)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _infoTile("Asset Class", "Stocks"),
                                    _infoTile("Asset Name", "TSLA"),
                                  ],
                                ),

                                SizedBox(height: ch(20)),

                                /// Description
                                Text(
                                  "A potential bullish reversal pattern has formed "
                                  "at the 1.0670 support area. Price has rejected "
                                  "this zone twice with strong buying volume. If momentum continues, "
                                  "we expect a short-term upside movement.",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    height: 1.4,
                                    fontSize: AppFontSize.f13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                SizedBox(height: ch(30)),

                                /// Trade Details Title
                                Text(
                                  "Trade Details",
                                  style: TextStyle(
                                    fontSize: AppFontSize.f18,
                                    color: AppColor.cFFFFFF,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: ch(10)),

                                /// Trade Table
                                _tradeRow(
                                  "Entry Price",
                                  "1.0700",
                                  "Buy limit entry near support",
                                ),
                                _tradeRow(
                                  "Stop Loss (SL)",
                                  "1.0650",
                                  "50 pips below entry",
                                ),
                                _tradeRow(
                                  "Take Profit 1 (TP1)",
                                  "1.0780",
                                  "Partial close at 80 pips gain",
                                ),
                                _tradeRow(
                                  "Take Profit 2 (TP2)",
                                  "1.0850",
                                  "Final target at resistance",
                                ),
                                _tradeRow(
                                  "Risk/Reward",
                                  "1:2.4",
                                  "Based on TP2",
                                ),

                                /// Strategy Note
                                Text(
                                  "Strategy Note",
                                  style: TextStyle(
                                    fontSize: AppFontSize.f14,
                                    color: AppColor.cFFFFFF,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: ch(12)),
                                Text(
                                  "Wait for confirmation candle close above 1.0705 "
                                  "before entering. If momentum weakens before hitting TP1, "
                                  "consider manual partial close.",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    height: 1.4,
                                    fontSize: AppFontSize.f13,
                                  ),
                                ),

                                SizedBox(height: ch(40)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// Reusable small info box
  Widget _infoTile(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColor.cFFFFFF,
            fontSize: AppFontSize.f10,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            color: AppColor.cFFFFFF,
            fontWeight: FontWeight.w500,
            fontSize: AppFontSize.f14,
          ),
        ),
      ],
    );
  }

  /// Trade Info Row
  Widget _tradeRow(String param, String val, String notes) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  param,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  val,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  notes,
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ),
            ],
          ),
          SizedBox(height: ch(12)),
          Divider(color: Colors.white12),
        ],
      ),
    );
  }
}
