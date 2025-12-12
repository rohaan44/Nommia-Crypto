import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/trade/trading_controller.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// --- 1. TradingController (State Management) ---
// (Copy the TradingController class from the section above here)

// --- Color Constants (Derived from Screenshot) ---
class TradeColors {
  // Backgrounds & Surfaces
  static const Color primaryBackground = Color(0xFF0D0F11);
  static const Color cardBackground = Color(0xFF1A1C1F);
  static const Color inactiveGrey = Color(
    0xFF2C303A,
  ); // Used for toggles/borders
  static const Color chartBackground = Color(0xFF141619);

  // Accent Colors
  static const Color accentYellow = Color(
    0xFFF0B90B,
  ); // Market / TP Toggle / CTA
  static const Color sellRed = Color(0xFFE8505B);
  static const Color textGrey = Color(0xFF8F96A3); // Secondary/Muted text
  static const Color white = Colors.white;
}

// --- Dummy Data (Used in Chart) ---
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

// --- 2. TradingScreen (UI Implementation) ---

class TradingScreen extends StatelessWidget {
  const TradingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide the controller to the widget tree
    return ChangeNotifierProvider(
      create: (_) => TradingController(),
      child: Scaffold(
        backgroundColor: TradeColors.primaryBackground,
        body: Column(
          children: [
            // Top Bar
            _buildHeader(context),
            // Chart Area (Expanded to take remaining space)
            _buildChartSection(),
            // Order Controls (Configuration UI)
            _buildOrderControls(),
            // Bottom Navigation
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: TradeColors.primaryBackground,
      padding: const EdgeInsets.fromLTRB(15, 40, 15, 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: TradeColors.cardBackground.withOpacity(0.5),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Icon(Icons.search, color: TradeColors.textGrey),
                  const SizedBox(width: 8),
                  Text(
                    "Search pairs ...",
                    style: TextStyle(color: TradeColors.textGrey, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: TradeColors.white,
            ),
            onPressed: () {},
          ),
          const CircleAvatar(
            radius: 18,
            backgroundColor: TradeColors.accentYellow,
            // Placeholder for the user's profile picture
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection() {
    return Expanded(
      child: Column(
        children: [
          // Sub-Header (AUDCAD / Trades 2 / P&L)
          Container(
            color: TradeColors.primaryBackground,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "AUDCAD",
                  style: TextStyle(
                    color: TradeColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _tradesInfo(),
                Row(
                  children: const [
                    Text(
                      "617.86",
                      style: TextStyle(
                        color: TradeColors.sellRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text("P&L", style: TextStyle(color: TradeColors.textGrey)),
                    SizedBox(width: 8),
                    // Live indicator
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SfCartesianChart(
              margin: EdgeInsets.zero,
              plotAreaBorderWidth: 0,
              backgroundColor: TradeColors.chartBackground,
              primaryXAxis: CategoryAxis(
                labelStyle: const TextStyle(color: TradeColors.textGrey),
                axisLine: const AxisLine(color: Colors.transparent),
                majorGridLines: const MajorGridLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                labelStyle: const TextStyle(color: TradeColors.textGrey),
                axisLine: const AxisLine(width: 0),
                majorGridLines: MajorGridLines(color: Colors.white12),
              ),
              series: <CandleSeries>[
                CandleSeries(
                  dataSource: _dummyData,
                  xValueMapper: (d, _) => d.time,
                  lowValueMapper: (d, _) => d.low,
                  highValueMapper: (d, _) => d.high,
                  openValueMapper: (d, _) => d.open,
                  closeValueMapper: (d, _) => d.close,
                  bearColor: TradeColors.sellRed, // Red candles
                  bullColor: const Color(0xFF38B25E), // Green candles
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tradesInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: TradeColors.accentYellow.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "Trades 2",
        style: TextStyle(color: TradeColors.accentYellow, fontSize: 12),
      ),
    );
  }

  Widget _buildOrderControls() {
    return Consumer<TradingController>(
      builder: (context, controller, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: TradeColors.primaryBackground,
          child: Column(
            children: [
              // 1. Market / Pending Toggle
              _buildTabToggle(controller),
              const SizedBox(height: 16),
              // 2. Sell / Buy Selector
              _buildBuySellSelector(controller),
              const SizedBox(height: 16),
              // 3. SL / TP Toggles
              _buildRiskToggles(controller),
              const SizedBox(height: 16),
              // 4. Input Grid (Dynamic based on Toggles)
              _buildDynamicInputs(controller),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // --- DYNAMIC INPUTS (KEY DESIGN ELEMENT) ---
  Widget _buildDynamicInputs(TradingController controller) {
    // The screen shows two input boxes.
    // Left Box: Could be SL or just empty placeholder.
    // Right Box: Could be TP or just empty placeholder.

    // Trade (2).png has TP ON and SL OFF. The two boxes show TP details on the right.
    if (controller.takeProfitEnabled && !controller.stopLossEnabled) {
      return Row(
        children: [
          // Left box acts as a general info box when SL is off
          Expanded(child: _buildPlaceholderBox()),
          const SizedBox(width: 12),
          // Right box shows TP values
          Expanded(child: _buildTakeProfitInputBox(controller)),
        ],
      );
    }

    // If both are ON (as seen in Frame 1)
    if (controller.takeProfitEnabled && controller.stopLossEnabled) {
      return Row(
        children: [
          // Left box shows SL values
          Expanded(child: _buildStopLossInputBox(controller)),
          const SizedBox(width: 12),
          // Right box shows TP values
          Expanded(child: _buildTakeProfitInputBox(controller)),
        ],
      );
    }

    // Default/Empty state if both are off
    return Container();
  }

  Widget _buildPlaceholderBox() {
    // Replicates the 0.89943 / 113 box from Trade (2).png
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: TradeColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "0.89943",
            style: TextStyle(color: TradeColors.textGrey, fontSize: 13),
          ),
          SizedBox(height: 4),
          Text("113", style: TextStyle(color: TradeColors.white, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildTakeProfitInputBox(TradingController controller) {
    // Replicates the Price/Pips box from Trade (2).png
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: TradeColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Price",
                style: TextStyle(color: TradeColors.textGrey, fontSize: 12),
              ),
              Text(
                controller.takeProfitPrice.toString(),
                style: const TextStyle(
                  color: TradeColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Pips",
                style: TextStyle(color: TradeColors.textGrey, fontSize: 12),
              ),
              Text(
                controller.takeProfitPips.toString(),
                style: const TextStyle(
                  color: TradeColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStopLossInputBox(TradingController controller) {
    // Design for Stop Loss input, dynamically showing Price, %, or Money based on _slInputMode

    // We can add a small button to switch input mode (as implied by Frame 1's percentage slider screens)
    final String label = controller.slInputMode == RiskInputMode.price
        ? "Price"
        : controller.slInputMode == RiskInputMode.percentage
        ? "Risk %"
        : "Money";

    // final String value = controller.slInputMode == RiskInputMode.price
    //     ? controller.stopLossPrice.toString()
    //     : controller.slInputMode == RiskInputMode.percentage
    //     ? "${controller.stopLossPercentage.toStringAsFixed(1)}%"
    //     : "\$${controller.stopLossMoney.toStringAsFixed(2)}";

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: TradeColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Stop Loss",
            style: TextStyle(color: TradeColors.textGrey, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: TradeColors.textGrey,
                  fontSize: 12,
                ),
              ),
              // Text(
              //   value,
              //   style: const TextStyle(
              //     color: TradeColors.sellRed,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 14,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Reusable Component Methods ---

  Widget _buildTabToggle(TradingController controller) {
    // Logic for Market/Pending toggle using controller.setOrderType
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: TradeColors.inactiveGrey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => controller.setOrderType(OrderType.market),
              child: Container(
                decoration: BoxDecoration(
                  color: controller.selectedOrderType == OrderType.market
                      ? TradeColors.accentYellow
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Market",
                  style: TextStyle(
                    color: controller.selectedOrderType == OrderType.market
                        ? Colors.black
                        : TradeColors.textGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => controller.setOrderType(OrderType.pending),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Pending",
                  style: TextStyle(
                    color: controller.selectedOrderType == OrderType.pending
                        ? TradeColors.white
                        : TradeColors.textGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuySellSelector(TradingController controller) {
    // Logic for Sell/Buy selector using controller.setTradeSide
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => controller.setTradeSide(TradeSide.sell),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: controller.selectedSide == TradeSide.sell
                    ? TradeColors.sellRed.withOpacity(0.2)
                    : TradeColors.cardBackground,
                border: Border.all(
                  color: controller.selectedSide == TradeSide.sell
                      ? TradeColors.sellRed
                      : TradeColors.cardBackground,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: Text(
                "Sell",
                style: TextStyle(
                  color: controller.selectedSide == TradeSide.sell
                      ? TradeColors.sellRed
                      : TradeColors.textGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => controller.setTradeSide(TradeSide.buy),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: controller.selectedSide == TradeSide.buy
                    ? const Color(0xFF38B25E).withOpacity(0.2)
                    : TradeColors.cardBackground,
                border: Border.all(
                  color: controller.selectedSide == TradeSide.buy
                      ? const Color(0xFF38B25E)
                      : TradeColors.cardBackground,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: Text(
                "Buy",
                style: TextStyle(
                  color: controller.selectedSide == TradeSide.buy
                      ? const Color(0xFF38B25E)
                      : TradeColors.textGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRiskToggles(TradingController controller) {
    // Logic for SL/TP/MultiTP toggles using controller.toggle...
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
        _buildSwitch("Multi TP", controller.multiTpEnabled, (v) {}),
      ],
    );
  }

  Widget _buildSwitch(String label, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(color: TradeColors.textGrey, fontSize: 12),
        ),
        const SizedBox(width: 4),
        Transform.scale(
          scale: 0.8,
          child: CupertinoSwitch(
            value: value,
            activeColor: TradeColors.accentYellow,
            trackColor: TradeColors.inactiveGrey,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Consumer<TradingController>(
      builder: (context, controller, child) {
        return Container(
          color: TradeColors.primaryBackground,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    _lotCounter(controller),
                    const SizedBox(width: 12),
                    _lotDropdown(),
                  ],
                ),
              ),
              // CTA Button
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TradeColors.accentYellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      controller.ctaButtonText,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // Bottom Nav Bar
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xFF222222))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem(Icons.public, "Trade", true),
                    _navItem(Icons.bar_chart, "Markets", false),
                    _navItem(Icons.home, "Home", false),
                    _navItem(Icons.copy_all, "Social", false),
                    _navItem(Icons.person_outline, "Accounts", false),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _lotCounter(TradingController controller) {
    return Expanded(
      flex: 2,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: TradeColors.inactiveGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => controller.setLotSize(controller.lotSize - 1),
              icon: const Icon(Icons.remove, color: TradeColors.textGrey),
            ),
            Text(
              controller.lotSize.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: TradeColors.white,
              ),
            ),
            IconButton(
              onPressed: () => controller.setLotSize(controller.lotSize + 1),
              icon: const Icon(Icons.add, color: TradeColors.textGrey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lotDropdown() {
    return Expanded(
      flex: 1,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: TradeColors.cardBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Lots", style: TextStyle(color: TradeColors.white)),
            Icon(Icons.keyboard_arrow_down, color: TradeColors.textGrey),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? TradeColors.accentYellow : TradeColors.textGrey,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? TradeColors.accentYellow : TradeColors.textGrey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

// For runnable code, you would need to add main() function and the TradingController class definition
// (which is provided in the first section)
