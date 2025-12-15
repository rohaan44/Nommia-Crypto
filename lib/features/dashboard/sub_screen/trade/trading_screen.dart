import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nommia_crypto/features/dashboard/home_screen_controller.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/trade/trading_controller.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/trade/widgets/trade_status_dialog.dart';

class TradingScreen extends StatelessWidget {
  const TradingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DashBoardScreenController>(context);

    return ChangeNotifierProvider(
      create: (_) => TradingController(),
      child: Scaffold(
        backgroundColor: AppColor.primaryBackground,
        body: Column(
          children: [
            //_buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 450,
                      child: _buildChartSection(context, model),
                    ),
                    _buildOrderControls(),
                  ],
                ),
              ),
            ),
            // _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  // Widget _buildHeader(BuildContext context) {
  //   return Container(
  //     color: AppColor.primaryBackground,
  //     padding: const EdgeInsets.fromLTRB(16, 50, 16, 10),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Container(
  //             height: 45,
  //             decoration: BoxDecoration(
  //               color: AppColor.cardBackground,
  //               borderRadius: BorderRadius.circular(25),
  //             ),
  //             child: Row(
  //               children: [
  //                 const SizedBox(width: 15),
  //                 const Icon(Icons.search, color: AppColor.textGrey, size: 22),
  //                 const SizedBox(width: 10),
  //                 AppText(
  //                   txt: "Search pairs ...",
  //                   color: AppColor.textGrey,
  //                   fontSize: AppFontSize.f14,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         const SizedBox(width: 16),
  //         const Icon(
  //           Icons.notifications_none,
  //           color: AppColor.textGrey,
  //           size: 26,
  //         ),
  //         const SizedBox(width: 16),
  //         const CircleAvatar(
  //           radius: 18,
  //           backgroundColor: AppColor.accentYellow,
  //           child: Icon(Icons.person, color: Colors.black, size: 24),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildChartSection(BuildContext context, model) {
    return Column(
      children: [
        _buildTradeInfoBar(context, model),
        _buildTimeframeToolbar(),
        Expanded(
          child: Container(
            color: AppColor.chartBackground,
            child: Row(
              children: [
                _buildChartSidebar(),
                Expanded(child: _buildMainChart()),
              ],
            ),
          ),
        ),
        _buildBottomChartBar(context),
      ],
    );
  }

  Widget _buildTradeInfoBar(BuildContext context, model) {
    return Container(
      color: AppColor.primaryBackground,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColor.white, width: 2),
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 2),
                child: AppText(
                  txt: "AUDCAD",
                  color: AppColor.white,
                  fontSize: AppFontSize.f14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          _tradesInfo(
            onTap: () {
              model.onBottomNavTap(4);
              // Navigator.pushNamedAndRemoveUntil(
              //   context,
              //   RoutePaths.marketScreen,
              //   (route) => false,
              // );
            },
          ),
          Row(
            children: [
              AppText(
                txt: "617.86",
                color: AppColor.buyGreen,
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.f14,
              ),
              const SizedBox(width: 4),
              AppText(
                txt: "P&L",
                color: AppColor.textGrey,
                fontSize: AppFontSize.f12,
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                color: AppColor.accentYellow,
                child: AppText(
                  txt: "LIVE",
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeframeToolbar() {
    return Container(
      color: AppColor.primaryBackground,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        children: [
          AppText(txt: "12M", color: AppColor.textGrey, fontSize: 13),
          const SizedBox(width: 10),
          Container(width: 1, height: 16, color: AppColor.divider),
          const SizedBox(width: 10),
          const Icon(
            Icons.candlestick_chart,
            color: AppColor.textGrey,
            size: 20,
          ),
          const SizedBox(width: 15),
          const Icon(Icons.show_chart, color: AppColor.textGrey, size: 20),
          const SizedBox(width: 15),
          const Icon(Icons.grid_view, color: AppColor.textGrey, size: 20),
          const Spacer(),
          const Icon(Icons.history, color: AppColor.textGrey, size: 20),
          const SizedBox(width: 15),
          const Icon(
            Icons.settings_outlined,
            color: AppColor.textGrey,
            size: 20,
          ),
          const SizedBox(width: 15),
          const Icon(Icons.fullscreen, color: AppColor.textGrey, size: 20),
        ],
      ),
    );
  }

  Widget _buildChartSidebar() {
    return Container(
      width: 40,
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: AppColor.divider)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Icon(Icons.add, color: AppColor.textGrey, size: 22),
          const SizedBox(height: 20),
          const Icon(Icons.show_chart, color: AppColor.textGrey, size: 22),
          const SizedBox(height: 20),
          const Icon(Icons.menu, color: AppColor.textGrey, size: 22),
          const SizedBox(height: 20),
          const Icon(Icons.brush, color: AppColor.textGrey, size: 22),
          const SizedBox(height: 20),
          const Icon(Icons.text_fields, color: AppColor.textGrey, size: 22),
          const SizedBox(height: 20),
          const Icon(
            Icons.emoji_emotions_outlined,
            color: AppColor.textGrey,
            size: 22,
          ),
          const Spacer(),
          const Icon(Icons.delete_outline, color: AppColor.textGrey, size: 20),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildMainChart() {
    return Stack(
      children: [
        SfCartesianChart(
          margin: EdgeInsets.zero,
          plotAreaBorderWidth: 0,
          backgroundColor: AppColor.chartBackground,
          primaryXAxis: CategoryAxis(
            isVisible: true,
            labelStyle: const TextStyle(color: AppColor.textGrey, fontSize: 10),
            majorGridLines: const MajorGridLines(
              width: 0.5,
              color: AppColor.divider,
            ),
          ),
          primaryYAxis: NumericAxis(
            isVisible: true,
            opposedPosition: true,
            labelStyle: const TextStyle(color: AppColor.textGrey, fontSize: 10),
            majorGridLines: const MajorGridLines(
              width: 0.5,
              color: AppColor.divider,
            ),
          ),
          series: <CandleSeries>[
            CandleSeries<CandleData, String>(
              dataSource: _dummyData,
              xValueMapper: (d, _) => d.time,
              lowValueMapper: (d, _) => d.low,
              highValueMapper: (d, _) => d.high,
              openValueMapper: (d, _) => d.open,
              closeValueMapper: (d, _) => d.close,
              bearColor: AppColor.sellRed,
              bullColor: AppColor.buyGreen,
              width: 0.2, // Reduced width
            ),
          ],
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        "50",
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  AppText(
                    txt: "Nifty 50 Index",
                    color: AppColor.lightGrey,
                    fontSize: 12,
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.sellRed.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: AppColor.sellRed,
                      size: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  _ohlcItem("O", "25,486.60", AppColor.buyGreen),
                  _ohlcItem("H", "25,516.10", AppColor.buyGreen),
                  _ohlcItem("L", "25,485.75", AppColor.buyGreen),
                  _ohlcItem("C", "25,510.80", AppColor.buyGreen),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _chartActionButton("25,492.30", "SELL", AppColor.sellRed),
                  const SizedBox(width: 8),
                  AppText(txt: "0.00", color: AppColor.textGrey, fontSize: 10),
                  const SizedBox(width: 8),
                  _chartActionButton(
                    "25,492.30",
                    "BUY",
                    const Color(0xff0B5AC3),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              AppText(
                txt: "Vol 21.8 M",
                color: const Color(0xff00C8B3),
                fontSize: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ohlcItem(String label, String val, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 9),
          children: [
            TextSpan(
              text: "$label ",
              style: const TextStyle(color: AppColor.textGrey),
            ),
            TextSpan(
              text: val,
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chartActionButton(String price, String type, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(4),
        color: color.withOpacity(0.1),
      ),
      child: Column(
        children: [
          AppText(
            txt: price,
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          AppText(txt: type, color: color, fontSize: 8),
        ],
      ),
    );
  }

  Widget _buildBottomChartBar(BuildContext context) {
    return Container(
      color: AppColor.primaryBackground,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColor.cardBackground,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColor.textGrey,
              size: 10,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _showDateRangeBottomSheet(context),
            child: Row(
              children: [
                AppText(
                  txt: "Date Range",
                  color: AppColor.textGrey,
                  fontSize: 11,
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColor.textGrey,
                  size: 14,
                ),
              ],
            ),
          ),
          const Spacer(),
          AppText(
            txt: "19:08:35 UTC+5:30",
            color: AppColor.textGrey,
            fontSize: 11,
          ),
          const SizedBox(width: 10),
          AppText(txt: "RTH", color: AppColor.textGrey, fontSize: 11),
          const SizedBox(width: 10),
          AppText(txt: "%", color: AppColor.textGrey, fontSize: 11),
          const SizedBox(width: 10),
          AppText(txt: "log", color: AppColor.textGrey, fontSize: 11),
          const SizedBox(width: 10),
          AppText(txt: "auto", color: Colors.blueAccent, fontSize: 11),
        ],
      ),
    );
  }

  Widget _tradesInfo({VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColor.accentYellow.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: AppText(
          txt: "Trades 2",
          color: AppColor.accentYellow,
          fontSize: AppFontSize.f12,
        ),
      ),
    );
  }

  Widget _buildOrderControls() {
    return Consumer<TradingController>(
      builder: (context, controller, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: AppColor.cardBackground,
          child: Column(
            children: [
              _buildTabToggle(controller),
              const SizedBox(height: 16),

              if (controller.selectedOrderType == OrderType.pending) ...[
                _buildPendingPriceInput(controller),
                const SizedBox(height: 16),
              ],

              _buildBuySellSelector(controller),
              const SizedBox(height: 16),
              // _buildRiskToggles(controller),
              _buildRiskToggles(controller),
              const SizedBox(height: 16),
              _buildDynamicInputs(context, controller),
              const SizedBox(height: 20),
              _buildMarginInfo(),
              _buildLotSizeSelector(controller),
              const SizedBox(height: 16),
              _buildExecuteButton(controller, context),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabToggle(TradingController controller) {
    return Container(
      height: 45,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColor.primaryBackground,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => controller.setOrderType(OrderType.market),
              child: Container(
                decoration: BoxDecoration(
                  color: controller.selectedOrderType == OrderType.market
                      ? AppColor.accentYellow
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: AppText(
                  txt: "Market",
                  color: controller.selectedOrderType == OrderType.market
                      ? Colors.black
                      : AppColor.textGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSize.f14,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => controller.setOrderType(OrderType.pending),
              child: Container(
                decoration: BoxDecoration(
                  color: controller.selectedOrderType == OrderType.pending
                      ? AppColor.accentYellow
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: AppText(
                  txt: "Pending",
                  color: controller.selectedOrderType == OrderType.pending
                      ? Colors.black
                      : AppColor.textGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSize.f14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuySellSelector(TradingController controller) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => controller.setTradeSide(TradeSide.sell),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: controller.selectedSide == TradeSide.sell
                    ? AppColor.sellRed
                    : AppColor.primaryBackground,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: controller.selectedSide == TradeSide.sell
                      ? AppColor.sellRed
                      : AppColor.sellRed.withOpacity(0.5),
                ),
              ),
              alignment: Alignment.center,
              child: AppText(
                txt: "Sell",
                color: controller.selectedSide == TradeSide.sell
                    ? AppColor.white
                    : AppColor.sellRed,
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.f16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => controller.setTradeSide(TradeSide.buy),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: controller.selectedSide == TradeSide.buy
                    ? AppColor.buyGreen
                    : AppColor.primaryBackground,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: controller.selectedSide == TradeSide.buy
                      ? AppColor.buyGreen
                      : AppColor.buyGreen.withOpacity(0.5),
                ),
              ),
              alignment: Alignment.center,
              child: AppText(
                txt: "Buy",
                color: controller.selectedSide == TradeSide.buy
                    ? AppColor.white
                    : AppColor.buyGreen,
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.f16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRiskToggles(TradingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSwitch(
          "Stop Loss",
          controller.stopLossEnabled,
          controller.toggleStopLoss,
        ),
        _buildSwitch(
          "Take Profit",
          controller.takeProfitEnabled,
          controller.toggleTakeProfit,
        ),
        _buildSwitch(
          "Multi TP",
          controller.multiTpEnabled,
          controller.toggleMultiTp,
        ),
      ],
    );
  }

  Widget _buildSwitch(String label, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        AppText(
          txt: label,
          color: AppColor.textGrey,
          fontSize: AppFontSize.f12,
        ),
        const SizedBox(width: 4),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            value: value,
            activeColor: AppColor.accentYellow,
            trackColor: AppColor.inactiveGrey,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicInputs(
    BuildContext context,
    TradingController controller,
  ) {
    // 1. If Multi-TP is enabled, show the list of TP levels
    if (controller.multiTpEnabled) {
      return Column(children: [_buildMultiTpSection(context, controller)]);
    }

    // 2. Standard SL/TP Logic
    // if (controller.takeProfitEnabled && !controller.stopLossEnabled) {
    //   return Row(
    //     children: [
    //       Expanded(child: _buildStopLossInputBox(controller)),
    //       const SizedBox(width: 12),
    //       Expanded(child: _buildTakeProfitInputBox(controller)),
    //     ],
    //   );
    // }
    if (controller.takeProfitEnabled || controller.stopLossEnabled) {
      return Row(
        children: [
          Expanded(child: _buildTakeProfitInputBox(controller)),
          const SizedBox(width: 12),
          Column(
            children: [
              AppText(txt: "Price", color: AppColor.textGrey, fontSize: 12),
              const SizedBox(height: 10),
              AppText(txt: "Pips", color: AppColor.textGrey, fontSize: 12),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(child: _buildTakeProfitInputBox(controller)),
        ],
      );
    }
    // If only SL shows
    // if (!controller.takeProfitEnabled && controller.stopLossEnabled) {
    //   return Row(
    //     children: [
    //       Expanded(child: _buildStopLossInputBox(controller)),
    //       const SizedBox(width: 12),
    //       Expanded(child: _buildPlaceholderBox()),
    //     ],
    //   );
    // }

    return Container();
  }

  // --- NEW: Pending Price Input ---
  Widget _buildPendingPriceInput(TradingController controller) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColor.primaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.accentYellow.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(txt: "Price", color: AppColor.textGrey, fontSize: 14),
          AppText(
            txt: controller.pendingOrderPrice.toString(),
            color: AppColor.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ],
      ),
    );
  }

  // --- NEW: Multi-TP Section ---
  Widget _buildMultiTpSection(
    BuildContext context,
    TradingController controller,
  ) {
    return Column(
      children: [
        _buildStatsGrid(),
        const SizedBox(height: 16),
        for (int i = 0; i < controller.multiTpLevels.length; i++)
          _buildMultiTpRow(context, controller, i),
        const SizedBox(height: 8),
        _buildAddTpButton(controller),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        Expanded(child: _buildStatsColumn(left: true)),
        const SizedBox(width: 8),
        Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppText(txt: "Price", color: AppColor.textGrey, fontSize: 10),
                SizedBox(height: ch(10)),
                AppText(txt: "Pips", color: AppColor.textGrey, fontSize: 10),
              ],
            ),

            Column(
              children: [
                SizedBox(height: ch(28)),
                AppText(txt: "P&L", color: AppColor.textGrey, fontSize: 10),
                SizedBox(height: ch(10)),
                AppText(txt: "%", color: AppColor.textGrey, fontSize: 10),
              ],
            ),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(child: _buildStatsColumn(left: false)),
      ],
    );
  }

  Widget _buildStatsColumn({required bool left}) {
    return Column(
      children: [
        Container(
          width: cw(150),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xff121212), // Darker background
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(txt: "0.89943", color: AppColor.textGrey, fontSize: 12),
              const SizedBox(height: 8),
              AppText(txt: "113", color: AppColor.textGrey, fontSize: 14),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: cw(150),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xff121212),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    txt: left ? "495.14" : "131.45",
                    color: AppColor.textGrey,
                    fontSize: 12,
                  ),
                  if (left)
                    AppText(txt: "\$", color: AppColor.textGrey, fontSize: 10),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    txt: left ? "0.49" : "0.13",
                    color: AppColor.textGrey,
                    fontSize: 14,
                  ),
                  if (left)
                    AppText(txt: "%", color: AppColor.textGrey, fontSize: 10),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddTpButton(TradingController controller) {
    bool isEnabled = controller.canAddMoreTpLevels;

    return GestureDetector(
      onTap: isEnabled ? () => controller.addNewTpLevel() : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColor.cardBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              color: isEnabled
                  ? AppColor.textGrey
                  : AppColor.inactiveGrey.withOpacity(0.5),
              size: 16,
            ),
            const SizedBox(width: 4),
            AppText(
              txt: "Take Profit",
              color: isEnabled
                  ? AppColor.textGrey
                  : AppColor.inactiveGrey.withOpacity(0.5),
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultiTpRow(
    BuildContext context,
    TradingController controller,
    int index,
  ) {
    final level = controller.multiTpLevels[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Row 1: Price Input
          Row(
            children: [
              SizedBox(
                width: 40,
                child: AppText(
                  txt: "Price",
                  color: AppColor.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                width: 120, // Adjust as needed
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff121212),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.centerRight,
                child: AppText(
                  txt: level.price.toString(),
                  color: AppColor.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Row 2: Slider + Percentage
          Row(
            children: [
              SizedBox(
                width: 40,
                child: AppText(
                  txt: "TP${index + 1}",
                  color: AppColor.textGrey,
                  fontSize: 12,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 20,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: AppColor.white,
                      inactiveTrackColor: AppColor.inactiveGrey.withOpacity(
                        0.3,
                      ),
                      thumbColor: AppColor.white,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 8,
                      ),
                      overlayShape: SliderComponentShape.noOverlay,
                      trackHeight: 2,
                      tickMarkShape: const RoundSliderTickMarkShape(
                        tickMarkRadius: 2,
                      ),
                      activeTickMarkColor: AppColor.inactiveGrey,
                      inactiveTickMarkColor: AppColor.inactiveGrey,
                    ),
                    child: Slider(
                      value: level.percentage,
                      min: 0,
                      max: 100,
                      divisions: 4, // 0, 25, 50, 75, 100
                      onChanged: (val) =>
                          controller.updateMultiTpPercentage(index, val),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 60,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xff121212),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: AppText(
                  txt: "${level.percentage.toInt()}%",
                  color: AppColor.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderBox() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.primaryBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(txt: "0.89943", color: AppColor.textGrey, fontSize: 13),
          const SizedBox(height: 2),
          AppText(
            txt: "113",
            color: AppColor.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildTakeProfitInputBox(TradingController controller) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.primaryBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                txt: controller.takeProfitPrice.toString(),
                color: AppColor.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                txt: controller.takeProfitPips.toString(),
                color: AppColor.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStopLossInputBox(TradingController controller) {
    String label = controller.slInputMode == RiskInputMode.price
        ? "Price"
        : "Money";
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.primaryBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(txt: "Stop Loss", color: AppColor.textGrey, fontSize: 12),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(txt: label, color: AppColor.textGrey, fontSize: 12),
            ],
          ),
        ],
      ),
    );
  }

  void _showDateRangeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    txt: "Filter closed portion",
                    color: AppColor.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 20),
                  AppText(txt: "From", color: AppColor.textGrey, fontSize: 14),
                  const SizedBox(height: 10),
                  _buildFilterOption("Last 24h", false),
                  _buildFilterOption("Last 7 days", false),
                  _buildFilterOption("Last 30 days", false),
                  _buildFilterOption("Last 365 days", false),
                  _buildFilterOption("custom range", false),
                  const SizedBox(height: 20),
                  const Divider(color: AppColor.divider),
                  const SizedBox(height: 20),
                  AppText(
                    txt: "Symbol",
                    color: AppColor.textGrey,
                    fontSize: 14,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColor.primaryBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: AppColor.textGrey,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        AppText(
                          txt: "Search",
                          color: AppColor.textGrey,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildFilterOption("CTPCF.HK", false),
                  _buildFilterOption("PEP.US", false),
                  _buildFilterOption("MCO.N", false),
                  _buildFilterOption("TGT.N", false),
                  _buildFilterOption("custom range", false),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterOption(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.textGrey),
            ),
          ),
          const SizedBox(width: 12),
          AppText(txt: label, color: AppColor.textGrey, fontSize: 14),
        ],
      ),
    );
  }

  // Widget _buildBottomNav() {
  //   return Consumer<TradingController>(
  //     builder: (context, controller, child) {
  //       return Container(
  //         color: AppColor.primaryBackground,
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 16.0,
  //                 vertical: 10,
  //               ),
  //               child: Row(
  //                 children: [
  //                   _lotCounter(controller),
  //                   const SizedBox(width: 12),
  //                   _lotDropdown(),
  //                 ],
  //               ),
  //             ),
  //             // CTA Button
  //             Padding(
  //               padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
  //               child: SizedBox(
  //                 width: double.infinity,
  //                 height: 55,
  //                 child: ElevatedButton(
  //                   onPressed: () {},
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: AppColor.accentYellow,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(28),
  //                     ),
  //                   ),
  //                   child: AppText(
  //                     txt: controller.ctaButtonText,
  //                     color: Colors.black,
  //                     fontSize: AppFontSize.f16,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             // Bottom Nav Bar
  //             // Container(
  //             //   padding: const EdgeInsets.symmetric(vertical: 8),
  //             //   decoration: const BoxDecoration(
  //             //     border: Border(top: BorderSide(color: AppColor.black)),
  //             //   ),
  //             //   child: Row(
  //             //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             //     children: [
  //             //       _navItem(Icons.public, "Trade", true),
  //             //       _navItem(Icons.bar_chart, "Markets", false),
  //             //       _navItem(Icons.home, "Home", false),
  //             //       _navItem(Icons.copy_all, "Social", false),
  //             //       _navItem(Icons.person_outline, "Accounts", false),
  //             //     ],
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _lotCounter(TradingController controller) {
  //   return Expanded(
  //     flex: 2,
  //     child: Container(
  //       height: 50,
  //       decoration: BoxDecoration(
  //         border: Border.all(color: AppColor.inactiveGrey),
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           IconButton(
  //             onPressed: () => controller.setLotSize(controller.lotSize - 1),
  //             icon: const Icon(Icons.remove, color: AppColor.textGrey),
  //           ),
  //           AppText(
  //             txt: controller.lotSize.toString(),
  //             fontSize: AppFontSize.f20,
  //             fontWeight: FontWeight.w500,
  //             color: AppColor.white,
  //           ),
  //           IconButton(
  //             onPressed: () => controller.setLotSize(controller.lotSize + 1),
  //             icon: const Icon(Icons.add, color: AppColor.textGrey),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _lotDropdown() {
  //   return Expanded(
  //     flex: 1,
  //     child: Container(
  //       height: 50,
  //       decoration: BoxDecoration(
  //         color: AppColor.cardBackground,
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       padding: const EdgeInsets.symmetric(horizontal: 12),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           AppText(txt: "Lots", color: AppColor.white),
  //           Icon(Icons.keyboard_arrow_down, color: AppColor.textGrey),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildMarginInfo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppText(
            txt: "\$13,119.15 (13.91%)",
            color: AppColor.white,
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.f12,
          ),
        ],
      ),
    );
  }

  Widget _buildLotSizeSelector(TradingController controller) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: AppColor.primaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.divider),
      ),
      child: Row(
        children: [
          _buildStepperButton(
            Icons.remove,
            () => controller.decrementLotSize(),
          ),
          Expanded(
            child: Center(
              child: AppText(
                txt: controller.lotSize.toString(),
                color: AppColor.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildStepperButton(Icons.add, () => controller.incrementLotSize()),
          Container(width: 1, height: 30, color: AppColor.divider),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                AppText(txt: "Lots", color: AppColor.white, fontSize: 14),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColor.textGrey,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepperButton(IconData icon, VoidCallback onTap) {
    return IconButton(
      icon: Icon(icon, color: AppColor.textGrey),
      onPressed: onTap,
    );
  }

  Widget _buildExecuteButton(
    TradingController controller,
    BuildContext context,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.accentYellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () {
          // Generate Random ID (Mock)
          String orderId = (1000000 + DateTime.now().millisecond).toString();

          // Determine Action Text & Color
          bool isBuy = controller.selectedSide == TradeSide.buy;
          String sideText = isBuy ? "BUY" : "SELL";
          Color actionColor = isBuy
              ? const Color(0xff0B5AC3)
              : AppColor.sellRed; // Matching Buy Blue / Sell Red

          String orderType = controller.selectedOrderType == OrderType.market
              ? "MARKET"
              : "LIMIT";
          String mainText = "$orderType $sideText";

          // Pending Logic tweak: if Pending + Buy -> Buy Limit. If Pending + Sell -> Sell Limit.
          if (controller.selectedOrderType == OrderType.pending) {
            mainText = "$sideText LIMIT";
          }

          // Show Dialog
          showDialog(
            context: context,
            builder: (context) => TradeStatusDialog(
              status: TradeStatus.success, // Mocking Success
              orderId: orderId,
              mainText: mainText,
              subText: controller.lotSize.toString(),
              symbol:
                  "GBPUSD", // Mocking dynamic symbol here, ideally from controller
              price: controller.selectedOrderType == OrderType.market
                  ? controller.executionPrice.toString()
                  : controller.pendingOrderPrice.toString(),
              mainColor: actionColor,
            ),
          );
        },
        child: AppText(
          txt: controller.ctaButtonText,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  //   Widget _navItem(IconData icon, String label, bool isActive) {
  //     return Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Icon(icon, color: isActive ? AppColor.accentYellow : AppColor.textGrey),
  //         const SizedBox(height: 4),
  //         AppText(
  //           txt: label,
  //           color: isActive ? AppColor.accentYellow : AppColor.textGrey,
  //           fontSize: AppFontSize.f10,
  //         ),
  //       ],
  //     );
  //   }
}

class CandleData {
  final String time;
  final double open, high, low, close;
  CandleData(this.time, this.open, this.high, this.low, this.close);
}

final List<CandleData> _dummyData = [
  CandleData('6', 25500, 25550, 25480, 25520),
  CandleData('12:00', 25520, 25540, 25490, 25500),
  CandleData('7', 25490, 25510, 25450, 25470),
  CandleData('12:00', 25470, 25500, 25460, 25490),
  CandleData('10', 25490, 25530, 25480, 25520),
];
