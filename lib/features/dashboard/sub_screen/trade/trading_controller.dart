import 'package:flutter/material.dart';

enum OrderType { market, pending }
enum TradeSide { buy, sell }
enum RiskInputMode { price, pips, percentage, money }

class TradingController with ChangeNotifier {
  final priceController = TextEditingController();
  final pipsController = TextEditingController();
  final percentageController = TextEditingController();
  late final TextEditingController sellController;
  final double _executionPrice = 0.89825;

  TradingController() {
    sellController = TextEditingController(text: _lotSize.toString());
    sellController.addListener(() {
      if (sellController.text.isNotEmpty) {
        double? lotSize = double.tryParse(sellController.text);
        if (lotSize != null) {
          setLotSize(lotSize, fromController: true);
        }
      }
    });
  }
  OrderType _selectedOrderType = OrderType.market;
  TradeSide _selectedSide = TradeSide.sell;
  double _lotSize = 6.0;

  bool _stopLossEnabled = false; // Initial State (Trade 2.png) is OFF
  bool _takeProfitEnabled = true; // Initial State (Trade 2.png) is ON
  bool _multiTpEnabled = false;

  RiskInputMode _slInputMode = RiskInputMode.price; // Can be Price, %, or Money
  double _stopLossPrice = 0.89700;
  int _stopLossPips = 30;

  double _takeProfitPrice = 0.89943;
  int _takeProfitPips = 30;
  double _pendingOrderPrice = 0.89800; // Default pending price
  final List<MultiTpLevel> _multiTpLevels = [
    MultiTpLevel(price: 0.89943, percentage: 13, isActive: true),
    MultiTpLevel(price: 0.89943, percentage: 50, isActive: true),
  ];

  OrderType get selectedOrderType => _selectedOrderType;
  TradeSide get selectedSide => _selectedSide;
  double get lotSize => _lotSize;
  double get executionPrice => _executionPrice;
  double get pendingOrderPrice => _pendingOrderPrice;
  bool get stopLossEnabled => _stopLossEnabled;
  bool get takeProfitEnabled => _takeProfitEnabled;
  bool get multiTpEnabled => _multiTpEnabled;

  RiskInputMode get slInputMode => _slInputMode;
  double get stopLossPrice => _stopLossPrice;
  int get stopLossPips => _stopLossPips;

  double get takeProfitPrice => _takeProfitPrice;
  int get takeProfitPips => _takeProfitPips;
  List<MultiTpLevel> get multiTpLevels => _multiTpLevels;

  int get maxTpLevels {
    if (_lotSize >= 0.03) return 3;
    if (_lotSize >= 0.02) return 2;
    return 1;
  }

  bool get canAddMoreTpLevels => _multiTpLevels.length < maxTpLevels;
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
    if (value) {
      _takeProfitEnabled = false;
      _stopLossEnabled = false;
    }
    notifyListeners();
  }

  void setLotSize(double newSize, {bool fromController = false}) {
    if (newSize >= 0.01) {
      _lotSize = newSize;

      if (!fromController) {
        String newText;
        if (newSize % 1 == 0) {
          newText = newSize.toInt().toString();
        } else {
          newText = newSize.toString();
        }
     if (sellController.text != newText) {
          sellController.text = newText;
          sellController.selection = TextSelection.fromPosition(
            TextPosition(offset: sellController.text.length),
          );
        }
      }
      int newLimit = maxTpLevels;
      if (_multiTpEnabled && _multiTpLevels.length > newLimit) {
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

    if (current > 1.00001) {
      step = 1.0;
    } else if (current > 0.10001) {
      step = 0.10;
    } else {
      step = 0.01;
    }
    double newValue = current - step;
    if (current > 1.0 && newValue < 1.0) {
      newValue = 1.0;
    } else if (current > 0.10 && newValue < 0.10) {
      newValue = 0.10;
    }

    if (newValue < 0.01) newValue = 0.01;

    setLotSize(double.parse(newValue.toStringAsFixed(2)));
  }

  // Example of changing the input mode (as seen in Frame 1)
  void setSlInputMode(RiskInputMode mode) {
    _slInputMode = mode;
    notifyListeners();
  }

  String get ctaButtonText {
    String side = _selectedSide == TradeSide.sell ? "SELL" : "BUY";
    String formattedLots = _lotSize.toStringAsFixed(2);
    String price = _selectedOrderType == OrderType.market
        ? _executionPrice.toString()
        : _pendingOrderPrice.toString();
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
