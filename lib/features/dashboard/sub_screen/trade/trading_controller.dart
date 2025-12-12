import 'package:flutter/material.dart';

enum OrderType { market, pending }
enum TradeSide { buy, sell }
enum RiskInputMode { price, pips, percentage, money }

class TradingController with ChangeNotifier {
  // --- Global Context & Pair ---
  final String _activePair = "AUDCAD";
  double _executionPrice = 0.89825; // Price from the bottom CTA
  int _tradesCount = 2;

  // --- Core Order Configuration ---
  OrderType _selectedOrderType = OrderType.market;
  TradeSide _selectedSide = TradeSide.sell;
  int _lotSize = 6;

  // --- Risk Management Toggles (SL/TP/MultiTP) ---
  bool _stopLossEnabled = false; // Initial State (Trade 2.png) is OFF
  bool _takeProfitEnabled = true; // Initial State (Trade 2.png) is ON
  bool _multiTpEnabled = false;

  // --- Stop Loss Details (Based on various states in Frame 1) ---
  RiskInputMode _slInputMode = RiskInputMode.price; // Can be Price, %, or Money
  double _stopLossPrice = 0.89700;
  int _stopLossPips = 30;
  double _stopLossPercentage = 10.0;
  double _stopLossMoney = 15.00; // Example value



  

  // --- Take Profit Details (Initial State from Trade 2.png) ---
  RiskInputMode _tpInputMode = RiskInputMode.price;
  double _takeProfitPrice = 0.89943;
  int _takeProfitPips = 30;
  double _takeProfitPercentage = 12.0;
  double _takeProfitMoney = 13.70; // Example value

  // --- Getters (For UI consumption) ---

  // Order Details
  OrderType get selectedOrderType => _selectedOrderType;
  TradeSide get selectedSide => _selectedSide;
  int get lotSize => _lotSize;
  double get executionPrice => _executionPrice;

  // Toggles
  bool get stopLossEnabled => _stopLossEnabled;
  bool get takeProfitEnabled => _takeProfitEnabled;
  bool get multiTpEnabled => _multiTpEnabled;

  // SL Details
  RiskInputMode get slInputMode => _slInputMode;
  double get stopLossPrice => _stopLossPrice;
  int get stopLossPips => _stopLossPips;

  // TP Details
  double get takeProfitPrice => _takeProfitPrice;
  int get takeProfitPips => _takeProfitPips;

  // --- Actions / Setters (Methods to update state) ---

  void setOrderType(OrderType type) {
    _selectedOrderType = type;
    notifyListeners();
  }

  void setTradeSide(TradeSide side) {
    _selectedSide = side;
    notifyListeners();
  }

  void toggleStopLoss(bool value) {
    _stopLossEnabled = value;
    notifyListeners();
  }

  void toggleTakeProfit(bool value) {
    _takeProfitEnabled = value;
    notifyListeners();
  }

  void setLotSize(int newSize) {
    if (newSize >= 1) {
      _lotSize = newSize;
      notifyListeners();
    }
  }

  // Example of changing the input mode (as seen in Frame 1)
  void setSlInputMode(RiskInputMode mode) {
    _slInputMode = mode;
    notifyListeners();
  }

  // Helper for CTA button text
  String get ctaButtonText {
    String side = _selectedSide == TradeSide.sell ? "SELL" : "BUY";
    String formattedLots = _lotSize.toStringAsFixed(2);
    return "$side $formattedLots @ $_executionPrice";
  }
}