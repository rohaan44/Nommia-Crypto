import 'package:flutter/material.dart';

enum OrderType { market, pending }

enum TradeSide { buy, sell }

enum RiskInputMode { price, pips, percentage, money }

class TradingController with ChangeNotifier {
  final priceController = TextEditingController();
  final pipsController = TextEditingController();
  final percentageController = TextEditingController();
  final moneyController = TextEditingController();
  // --- Global Context & Pair ---
  final String _activePair = "AUDCAD";
  double _executionPrice = 0.89825; // Price from the bottom CTA
  int _tradesCount = 2;

  // --- Core Order Configuration ---
  OrderType _selectedOrderType = OrderType.market;
  TradeSide _selectedSide = TradeSide.sell;
  double _lotSize = 6.0;

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

  // --- Pending Order Details ---
  double _pendingOrderPrice = 0.89800; // Default pending price

  // --- Multi TP Details ---
  final List<MultiTpLevel> _multiTpLevels = [
    MultiTpLevel(price: 0.89943, percentage: 13, isActive: true),
    MultiTpLevel(price: 0.89943, percentage: 50, isActive: true),
  ];

  // --- Getters (For UI consumption) ---

  // Order Details
  OrderType get selectedOrderType => _selectedOrderType;
  TradeSide get selectedSide => _selectedSide;
  double get lotSize => _lotSize;
  double get executionPrice => _executionPrice;
  double get pendingOrderPrice => _pendingOrderPrice;

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
  List<MultiTpLevel> get multiTpLevels => _multiTpLevels;

  int get maxTpLevels {
    if (_lotSize >= 0.03) return 3;
    if (_lotSize >= 0.02) return 2;
    return 1;
  }

  bool get canAddMoreTpLevels => _multiTpLevels.length < maxTpLevels;

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
    if (value) {
      _takeProfitEnabled = false;
      _multiTpEnabled = false;
    }
    notifyListeners();
  }

  void toggleTakeProfit(bool value) {
    _takeProfitEnabled = value;
    if (value) {
      _multiTpEnabled = false;
      _stopLossEnabled = false;
    }
    notifyListeners();
  }

  void toggleMultiTp(bool value) {
    _multiTpEnabled = value;
    // If Multi TP is ON, standard TP toggle effectively becomes controlled by it
    if (value) {
      _takeProfitEnabled = false;
      _stopLossEnabled = false;
    }
    notifyListeners();
  }

  void setLotSize(double newSize) {
    if (newSize >= 0.01) {
      _lotSize = newSize;

      // Enforce TP Limit when Lot Size decreases
      // We calculate the new limit immediately
      int newLimit = maxTpLevels;
      if (_multiTpEnabled && _multiTpLevels.length > newLimit) {
        // Keep only the first 'newLimit' items
        // e.g. if length is 3 and limit becomes 2, remove last
        _multiTpLevels.removeRange(newLimit, _multiTpLevels.length);
      }

      notifyListeners();
    }
  }

  void incrementLotSize() {
    double current = double.parse(_lotSize.toStringAsFixed(2));
    double step = 0.01;

    if (current >= 1.0) {
      step = 1.0;
    } else if (current >= 0.10) {
      step = 0.10;
    } else {
      step = 0.01;
    }

    setLotSize(double.parse((current + step).toStringAsFixed(2)));
  }

  void decrementLotSize() {
    double current = double.parse(_lotSize.toStringAsFixed(2));
    double step = 0.01;

    // Logic: snap to next lower interval
    // If > 1.0, subtract 1.0.
    // If <= 1.0 and > 0.10, subtract 0.10.
    // If <= 0.10, subtract 0.01.

    // Edge case handling for exact boundaries often implies we drop down into the smaller interval.
    // e.g. 1.0 -> 0.9. (1.0 is the boundary. 1.0 - 0.1 = 0.9).
    // e.g. 0.1 -> 0.09. (0.1 is the boundary. 0.1 - 0.01 = 0.09).

    if (current > 1.00001) {
      step = 1.0;
    } else if (current > 0.10001) {
      step = 0.10;
    } else {
      step = 0.01;
    }

    double newValue = current - step;
    if (newValue < 0.01) newValue = 0.01;

    setLotSize(double.parse(newValue.toStringAsFixed(2)));
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
    String price = _selectedOrderType == OrderType.market
        ? _executionPrice.toString()
        : _pendingOrderPrice.toString();

    // Logic to show "Limit" or "Stop" based on pending price relative to market could go here
    String orderAction = _selectedOrderType == OrderType.market
        ? side
        : "$side LIMIT";

    return "$orderAction $formattedLots @ $price";
  }

  void updateMultiTpLevel(int index, bool value) {
    if (index >= 0 && index < _multiTpLevels.length) {
      _multiTpLevels[index].isActive = value;
      notifyListeners();
    }
  }

  void updateMultiTpPercentage(int index, double value) {
    if (index >= 0 && index < _multiTpLevels.length) {
      _multiTpLevels[index].percentage = value;
      notifyListeners();
    }
  }

  void addNewTpLevel() {
    if (!canAddMoreTpLevels) return;

    // Logic to add a new level, defaulting to sensible values
    _multiTpLevels.add(
      MultiTpLevel(price: _executionPrice, percentage: 10, isActive: true),
    );
    notifyListeners();
  }
}

class MultiTpLevel {
  double price;
  double percentage;
  bool isActive;

  MultiTpLevel({
    required this.price,
    required this.percentage,
    required this.isActive,
  });
}
