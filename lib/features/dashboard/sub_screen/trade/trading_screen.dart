import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nommia_crypto/features/dashboard/home_screen_controller.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/trade/trading_controller.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_dismis_keyboard.dart';
import 'package:nommia_crypto/ui_molecules/primary_textfield.dart';
import 'package:nommia_crypto/utils/asset_utils.dart';
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

    return AppDismissKeyboard(
      child: ChangeNotifierProvider(
        create: (controller) => TradingController(),
        child: Column(
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
              model.onBottomNavTap(2);
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
              SizedBox(width: cw(10)),
              Container(
                width: cw(60),
                height: ch(15),
                padding: EdgeInsets.only(left: cw(8)),
                decoration: BoxDecoration(
                  color: AppColor.buyGreen.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(cw(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      txt: "P&L",
                      color: AppColor.white,
                      fontSize: AppFontSize.f12,
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(cw(12)),
                          bottomRight: Radius.circular(cw(12)),
                        ),
                      ),
                      child: AppText(
                        txt: "LIVE",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
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
            fontWeight: FontWeight.w400,
          ),
          AppText(txt: type, color: color, fontSize: 8),
        ],
      ),
    );
  }

  Widget _buildBottomChartBar(BuildContext context) {
    return Container(
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
      child: Row(
        children: [
          AppText(
            txt: "Trades",
            color: AppColor.white.withOpacity(0.5),
            fontSize: AppFontSize.f12,
            fontWeight: FontWeight.w400,
          ),
          Container(
            margin: const EdgeInsets.only(left: 6),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColor.accentYellow,
              borderRadius: BorderRadius.circular(50),
            ),
            child: AppText(
              txt: "2",
              color: Colors.black,
              fontSize: AppFontSize.f12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderControls() {
    return Consumer<TradingController>(
      builder: (context, controller, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          // color: AppColor.cardBackground,
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
        color: AppColor.c1F242A,
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
                  fontWeight: FontWeight.w400,
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
                  fontWeight: FontWeight.w400,
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
    return Container(
      decoration: BoxDecoration(
        color: AppColor.c1F242A,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => controller.setTradeSide(TradeSide.sell),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: controller.selectedSide == TradeSide.sell
                      ? AppColor.sellRed.withOpacity(0.3)
                      : AppColor.transparent,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: controller.selectedSide == TradeSide.sell
                        ? AppColor.sellRed
                        : AppColor.transparent,
                  ),
                ),
                alignment: Alignment.center,
                child: AppText(
                  txt: "Sell",
                  color: AppColor.sellRed,
                  fontWeight: FontWeight.w500,
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
                      ? AppColor.buyGreen.withOpacity(0.3)
                      : AppColor.transparent,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: controller.selectedSide == TradeSide.buy
                        ? AppColor.buyGreen
                        : AppColor.transparent,
                  ),
                ),
                alignment: Alignment.center,
                child: AppText(
                  txt: "Buy",
                  color: AppColor.buyGreen,
                  fontWeight: FontWeight.w400,
                  fontSize: AppFontSize.f16,
                ),
              ),
            ),
          ),
        ],
      ),
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
    return Column(
      children: [
        _buildStatsGrid(
          amount: "0.89700",
          amountRight: "0.89943",
          amountUnit: "",
          amountUnitRight: "",
          //  percent: "0.13",
          percentUnit: "%",
          label: "Price",
          isLeftEnabled: controller.stopLossEnabled,
          isRightEnabled:
              controller.takeProfitEnabled && !controller.multiTpEnabled,
        ),
        _buildStatsGrid(
          amount: "113",
          amountRight: "30",
          amountUnit: "",
          amountUnitRight: "",
          //  percent: "0.13",
          percentUnit: "%",
          label: "Pips",
          isLeftEnabled: controller.stopLossEnabled,
          isRightEnabled:
              controller.takeProfitEnabled && !controller.multiTpEnabled,
        ),
        if (controller.multiTpEnabled) ...[
          const SizedBox(height: 16),
          _buildMultiTpSection(context, controller),
        ],
        if (controller.takeProfitEnabled || controller.stopLossEnabled) ...[
          const SizedBox(height: 16),
          _buildStatsGrid(
            amount: "495.14",
            amountRight: "131.45",
            amountUnit: "\$",
            amountUnitRight: "\$",
            //  percent: "0.13",
            percentUnit: "%",
            label: "P&L",
            isLeftEnabled: controller.stopLossEnabled,
            isRightEnabled:
                controller.takeProfitEnabled && !controller.multiTpEnabled,
          ),

          _buildStatsGrid(
            amount: "0.49",
            amountRight: "0.13",
            amountUnit: "%",
            amountUnitRight: "%",
            // percent: "0.49",
            percentUnit: "%",
            label: "%",
            isLeftEnabled: controller.stopLossEnabled,
            isRightEnabled:
                controller.takeProfitEnabled && !controller.multiTpEnabled,
          ),

          const SizedBox(height: 16),
        ],
      ],
    );
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
          SizedBox(width: cw(50)),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                fillColor: AppColor.transparent,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isCollapsed: true,
              ),
              textAlign: TextAlign.right,
              controller: TextEditingController(
                text: controller.pendingOrderPrice.toString(),
              ),
            ),
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
        _buildStatsGrid(
          amount: "495.14",
          amountRight: "131.45",
          amountUnit: "\$",
          amountUnitRight: "\$",
          //  percent: "0.13",
          percentUnit: "%",
          label: "P&L",
          isLeftEnabled: controller.stopLossEnabled,
          isRightEnabled:
              controller.takeProfitEnabled && !controller.multiTpEnabled,
        ),

        _buildStatsGrid(
          amount: "0.49",
          amountRight: "0.13",
          amountUnit: "%",
          amountUnitRight: "%",
          // percent: "0.49",
          percentUnit: "%",
          label: "%",
          isLeftEnabled: controller.stopLossEnabled,
          isRightEnabled:
              controller.takeProfitEnabled && !controller.multiTpEnabled,
        ),

        const SizedBox(height: 16),

        for (int i = 0; i < controller.multiTpLevels.length; i++)
          _buildMultiTpRow(context, controller, i),
        const SizedBox(height: 8),
        _buildAddTpButton(controller),
      ],
    );
  }

  Widget _buildStatsGrid({
    required String amount,
    required String amountUnit,
    required String amountRight,
    required String amountUnitRight,
    required String percentUnit,
    String label = "P&L",
    bool isLeftEnabled = true,
    bool isRightEnabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: cw(150),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xff121212),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    label == "P&L" || label == "Price" ? 12 : 0,
                  ),
                  topRight: Radius.circular(
                    label == "P&L" || label == "Price" ? 12 : 0,
                  ),
                  bottomLeft: Radius.circular(
                    label == "%" || label == "Pips" ? 12 : 0,
                  ),
                  bottomRight: Radius.circular(
                    label == "%" || label == "Pips" ? 12 : 0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: ch(20),
                          child: TextField(
                            enabled: isLeftEnabled,
                            controller: TextEditingController(text: amount),
                            style: TextStyle(
                              color: isLeftEnabled
                                  ? AppColor.white
                                  : AppColor.textGrey,
                              fontSize: AppFontSize.f12,
                            ),
                            decoration: const InputDecoration(
                              fillColor: AppColor.transparent,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),
                      AppText(
                        txt: amountUnit,
                        color: isLeftEnabled
                            ? AppColor.white
                            : AppColor.textGrey,
                        fontSize: AppFontSize.f12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(width: 8),
            AppText(txt: label, color: AppColor.textGrey, fontSize: 10),
            const SizedBox(width: 8),
            Container(
              width: cw(150),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xff121212),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    label == "P&L" || label == "Price" ? 12 : 0,
                  ),
                  topRight: Radius.circular(
                    label == "P&L" || label == "Price" ? 12 : 0,
                  ),
                  bottomLeft: Radius.circular(
                    label == "%" || label == "Pips" ? 12 : 0,
                  ),
                  bottomRight: Radius.circular(
                    label == "%" || label == "Pips" ? 12 : 0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: ch(20),
                          child: TextField(
                            enabled: isRightEnabled,
                            controller: TextEditingController(
                              text: amountRight,
                            ),
                            style: TextStyle(
                              color: isRightEnabled
                                  ? AppColor.white
                                  : AppColor.textGrey,
                              fontSize: AppFontSize.f12,
                            ),
                            decoration: const InputDecoration(
                              fillColor: AppColor.transparent,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),
                      AppText(
                        txt: amountUnitRight,
                        color: isRightEnabled
                            ? AppColor.white
                            : AppColor.textGrey,
                        fontSize: AppFontSize.f12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
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
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Container(
                height: ch(40),
                width: cw(120), // Adjust as needed
                decoration: BoxDecoration(
                  color: const Color(0xff121212),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: TextField(
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(
                    text: level.price.toString(),
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(right: cw(10)),
                    fillColor: AppColor.transparent,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "0.89943",
                    hintStyle: TextStyle(
                      color: AppColor.textGrey,
                      fontSize: 12,
                    ),
                  ),
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
                      trackHeight: 3,
                      tickMarkShape: const RoundSliderTickMarkShape(
                        tickMarkRadius: 3,
                      ),
                      activeTickMarkColor: AppColor.inactiveGrey,
                      inactiveTickMarkColor: AppColor.inactiveGrey,
                    ),
                    child: Slider(
                      value: level.percentage,
                      min: 0,
                      max: 100,
                      divisions: 100, // 0, 25, 50, 75, 100
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
            return ListView(
              shrinkWrap: true,
              controller: scrollController,
              padding: EdgeInsets.symmetric(horizontal: cw(40), vertical: 20),
              children: [
                SizedBox(height: ch(20)),
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
                _buildFilterOption("Custom range", false),

                const SizedBox(height: 20),
                const Divider(color: AppColor.divider),
                const SizedBox(height: 20),

                AppText(txt: "Symbol", color: AppColor.textGrey, fontSize: 14),
                const SizedBox(height: 10),

                primaryTextField(
                  fillColor: AppColor.primaryBackground,
                  hintText: "Search",
                  prefixIcon: SvgPicture.asset(AssetUtils.searchIcon),
                ),

                const SizedBox(height: 10),
                _buildFilterOption("CTPCF.HK", false),
                _buildFilterOption("PEP.US", false),
                _buildFilterOption("MCO.N", false),
                _buildFilterOption("TGT.N", false),

                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xff575B60)),
                        ),
                        onPressed: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: ch(45),
                          child: AppText(
                            fontWeight: FontWeight.w400,
                            txt: "Clear",
                            color: Color(0xff575B60),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColor.accentYellow,

                          side: const BorderSide(color: AppColor.transparent),
                        ),
                        onPressed: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: ch(45),
                          child: AppText(
                            fontWeight: FontWeight.w400,
                            txt: "Apply",
                            color: Color.fromARGB(255, 0, 4, 8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
              borderRadius: BorderRadius.circular(cw(5)),
              shape: BoxShape.rectangle,
              border: Border.all(color: Color(0xff787B7F)),
            ),
          ),
          const SizedBox(width: 12),
          AppText(
            txt: label,
            color: AppColor.textGrey,
            fontSize: AppFontSize.f13,
          ),
        ],
      ),
    );
  }

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
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(color: AppColor.white),
              decoration: InputDecoration(
                fillColor: AppColor.transparent,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isCollapsed: true,
              ),
              textAlign: TextAlign.center,
              onChanged: (value) {
                double? val = double.tryParse(value);
                if (val != null) {
                  controller.setLotSize(val);
                }
              },
              controller: TextEditingController(
                text: controller.lotSize.toString(),
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

          // Randomize Status for Demo
          bool isSuccess = DateTime.now().millisecond % 2 == 0;
          TradeStatus status = isSuccess
              ? TradeStatus.success
              : TradeStatus.failed;

          // Show Dialog
          showDialog(
            context: context,
            builder: (context) => TradeStatusDialog(
              status: status,
              orderId: orderId,
              mainText: mainText,
              subText: controller.lotSize.toString(),
              symbol: "GBPUSD",
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
