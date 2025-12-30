import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  //String _selectedAccount = "Account 1";
  String _selectedTab = "Open";

  


  final List<TradeItem> _trades = [
    TradeItem(
      symbol: "GBPUSD",
      type: "BUY",
      profit: -558.57,
      volume: 1.00,
      openPrice: 1.33180,
      time: "09/10/2025, 15:09:23",
      isLoss: true,
      status: "Open",
    ),
    TradeItem(
      symbol: "GBPUSD",
      type: "BUY",
      profit: -558.57,
      volume: 1.00,
      openPrice: 1.33180,
      time: "09/10/2025, 15:09:23",
      isLoss: true,
      status: "Open",
    ),
    TradeItem(
      symbol: "GBPUSD",
      type: "BUY",
      profit: -558.57,
      volume: 1.00,
      openPrice: 1.33180,
      time: "09/10/2025, 15:09:23",
      isLoss: true,
      status: "Open",
    ),
    TradeItem(
      symbol: "EURUSD",
      type: "SELL",
      profit: 250.00,
      volume: 0.50,
      openPrice: 1.0520,
      time: "09/10/2025, 14:30:00",
      isLoss: false,
      status: "Open",
    ),
    TradeItem(
      symbol: "EURUSD",
      type: "SELL",
      profit: 250.00,
      volume: 0.50,
      openPrice: 1.0520,
      time: "09/10/2025, 14:30:00",
      isLoss: false,
      status: "Open",
    ),
    TradeItem(
      symbol: "EURUSD",
      type: "SELL",
      profit: 250.00,
      volume: 0.50,
      openPrice: 1.0520,
      time: "09/10/2025, 14:30:00",
      isLoss: false,
      status: "Open",
    ),
    TradeItem(
      symbol: "EURUSD",
      type: "SELL",
      profit: 250.00,
      volume: 0.50,
      openPrice: 1.0520,
      time: "09/10/2025, 14:30:00",
      isLoss: false,
      status: "Open",
    ),
    TradeItem(
      symbol: "EURUSD",
      type: "SELL",
      profit: 250.00,
      volume: 0.50,
      openPrice: 1.0520,
      time: "09/10/2025, 14:30:00",
      isLoss: false,
      status: "Open",
    ),
    TradeItem(
      symbol: "EURUSD",
      type: "SELL",
      profit: 250.00,
      volume: 0.50,
      openPrice: 1.0520,
      time: "09/10/2025, 14:30:00",
      isLoss: false,
      status: "Open",
    ),
    TradeItem(
      symbol: "EURUSD",
      type: "SELL",
      profit: 250.00,
      volume: 0.50,
      openPrice: 1.0520,
      time: "09/10/2025, 14:30:00",
      isLoss: false,
      status: "Open",
    ),
    TradeItem(
      symbol: "EURUSD",
      type: "SELL",
      profit: 250.00,
      volume: 0.50,
      openPrice: 1.0520,
      time: "09/10/2025, 14:30:00",
      isLoss: false,
      status: "Open",
    ),
    TradeItem(
      symbol: "BTCUSD",
      type: "BUY",
      profit: 0.0,
      volume: 2.00,
      openPrice: 65000.0,
      time: "10/10/2025, 09:00:00",
      isLoss: false,
      status: "Pending",
    ),
    TradeItem(
      symbol: "BTCUSD",
      type: "BUY",
      profit: 0.0,
      volume: 2.00,
      openPrice: 65000.0,
      time: "10/10/2025, 09:00:00",
      isLoss: false,
      status: "Pending",
    ),
    TradeItem(
      symbol: "BTCUSD",
      type: "BUY",
      profit: 0.0,
      volume: 2.00,
      openPrice: 65000.0,
      time: "10/10/2025, 09:00:00",
      isLoss: false,
      status: "Pending",
    ),
    TradeItem(
      symbol: "BTCUSD",
      type: "BUY",
      profit: 0.0,
      volume: 2.00,
      openPrice: 65000.0,
      time: "10/10/2025, 09:00:00",
      isLoss: false,
      status: "Pending",
    ),
    TradeItem(
      symbol: "BTCUSD",
      type: "BUY",
      profit: 0.0,
      volume: 2.00,
      openPrice: 65000.0,
      time: "10/10/2025, 09:00:00",
      isLoss: false,
      status: "Pending",
    ),
    TradeItem(
      symbol: "BTCUSD",
      type: "BUY",
      profit: 0.0,
      volume: 2.00,
      openPrice: 65000.0,
      time: "10/10/2025, 09:00:00",
      isLoss: false,
      status: "Pending",
    ),
    TradeItem(
      symbol: "BTCUSD",
      type: "BUY",
      profit: 0.0,
      volume: 2.00,
      openPrice: 65000.0,
      time: "10/10/2025, 09:00:00",
      isLoss: false,
      status: "Pending",
    ),
    TradeItem(
      symbol: "BTCUSD",
      type: "BUY",
      profit: 0.0,
      volume: 2.00,
      openPrice: 65000.0,
      time: "10/10/2025, 09:00:00",
      isLoss: false,
      status: "Pending",
    ),
    TradeItem(
      symbol: "BTCUSD",
      type: "BUY",
      profit: 0.0,
      volume: 2.00,
      openPrice: 65000.0,
      time: "10/10/2025, 09:00:00",
      isLoss: false,
      status: "Pending",
    ),
    TradeItem(
      symbol: "BTCUSD",
      type: "BUY",
      profit: 0.0,
      volume: 2.00,
      openPrice: 65000.0,
      time: "10/10/2025, 09:00:00",
      isLoss: false,
      status: "Pending",
    ),
    TradeItem(
      symbol: "BTCUSD",
      type: "BUY",
      profit: 0.0,
      volume: 2.00,
      openPrice: 65000.0,
      time: "10/10/2025, 09:00:00",
      isLoss: false,
      status: "Pending",
    ),
    TradeItem(
      symbol: "BTCUSD",
      type: "BUY",
      profit: 0.0,
      volume: 2.00,
      openPrice: 65000.0,
      time: "10/10/2025, 09:00:00",
      isLoss: false,
      status: "Pending",
    ),
    TradeItem(
      symbol: "BTCUSD",
      type: "BUY",
      profit: 0.0,
      volume: 2.00,
      openPrice: 65000.0,
      time: "10/10/2025, 09:00:00",
      isLoss: false,
      status: "Pending",
    ),
    TradeItem(
      symbol: "BTCUSD",
      type: "BUY",
      profit: 0.0,
      volume: 2.00,
      openPrice: 65000.0,
      time: "10/10/2025, 09:00:00",
      isLoss: false,
      status: "Pending",
    ),
    TradeItem(
      symbol: "XAUUSD",
      type: "SELL",
      profit: 1200.00,
      volume: 1.00,
      openPrice: 1950.00,
      time: "08/10/2025, 10:00:00",
      isLoss: false,
      status: "Closed",
    ),
    TradeItem(
      symbol: "XAUUSD",
      type: "SELL",
      profit: 1200.00,
      volume: 1.00,
      openPrice: 1950.00,
      time: "08/10/2025, 10:00:00",
      isLoss: false,
      status: "Closed",
    ),
    TradeItem(
      symbol: "XAUUSD",
      type: "SELL",
      profit: 1200.00,
      volume: 1.00,
      openPrice: 1950.00,
      time: "08/10/2025, 10:00:00",
      isLoss: false,
      status: "Closed",
    ),
    TradeItem(
      symbol: "XAUUSD",
      type: "SELL",
      profit: 1200.00,
      volume: 1.00,
      openPrice: 1950.00,
      time: "08/10/2025, 10:00:00",
      isLoss: false,
      status: "Closed",
    ),
    TradeItem(
      symbol: "XAUUSD",
      type: "SELL",
      profit: 1200.00,
      volume: 1.00,
      openPrice: 1950.00,
      time: "08/10/2025, 10:00:00",
      isLoss: false,
      status: "Closed",
    ),
    TradeItem(
      symbol: "XAUUSD",
      type: "SELL",
      profit: 1200.00,
      volume: 1.00,
      openPrice: 1950.00,
      time: "08/10/2025, 10:00:00",
      isLoss: false,
      status: "Closed",
    ),
    TradeItem(
      symbol: "XAUUSD",
      type: "SELL",
      profit: 1200.00,
      volume: 1.00,
      openPrice: 1950.00,
      time: "08/10/2025, 10:00:00",
      isLoss: false,
      status: "Closed",
    ),
    TradeItem(
      symbol: "XAUUSD",
      type: "SELL",
      profit: 1200.00,
      volume: 1.00,
      openPrice: 1950.00,
      time: "08/10/2025, 10:00:00",
      isLoss: false,
      status: "Closed",
    ),
    TradeItem(
      symbol: "XAUUSD",
      type: "SELL",
      profit: 1200.00,
      volume: 1.00,
      openPrice: 1950.00,
      time: "08/10/2025, 10:00:00",
      isLoss: false,
      status: "Closed",
    ),
    TradeItem(
      symbol: "XAUUSD",
      type: "SELL",
      profit: 1200.00,
      volume: 1.00,
      openPrice: 1950.00,
      time: "08/10/2025, 10:00:00",
      isLoss: false,
      status: "Closed",
    ),
    TradeItem(
      symbol: "XAUUSD",
      type: "SELL",
      profit: 1200.00,
      volume: 1.00,
      openPrice: 1950.00,
      time: "08/10/2025, 10:00:00",
      isLoss: false,
      status: "Closed",
    ),
    TradeItem(
      symbol: "XAUUSD",
      type: "SELL",
      profit: 1200.00,
      volume: 1.00,
      openPrice: 1950.00,
      time: "08/10/2025, 10:00:00",
      isLoss: false,
      status: "Closed",
    ),
    TradeItem(
      symbol: "XAUUSD",
      type: "SELL",
      profit: 1200.00,
      volume: 1.00,
      openPrice: 1950.00,
      time: "08/10/2025, 10:00:00",
      isLoss: false,
      status: "Closed",
    ),
    TradeItem(
      symbol: "XAUUSD",
      type: "SELL",
      profit: 1200.00,
      volume: 1.00,
      openPrice: 1950.00,
      time: "08/10/2025, 10:00:00",
      isLoss: false,
      status: "Closed",
    ),
    TradeItem(
      symbol: "ETHUSD",
      type: "BUY",
      profit: -150.00,
      volume: 5.00,
      openPrice: 3500.00,
      time: "07/10/2025, 12:00:00",
      isLoss: true,
      status: "Closed",
    ),
  ];

 String get selectedTab => _selectedTab;

  List<TradeItem> get trades =>
      _trades.where((t) => t.status == _selectedTab).toList();

  // void setAccount(String account) {
  //   _selectedAccount = account;
  //   notifyListeners();
  // }

  void setTab(String tab) {
    _selectedTab = tab;
    notifyListeners();
  }

  void removeTrade(TradeItem trade) {
    _trades.remove(trade);
    notifyListeners();
  }

     final accountList = ["Account #1", "Account #2", "Account #3", "Account #4"];

  String? _selectedAccount;

  String? get selectedAccount => _selectedAccount;
  set selectedAccount(String? value) {
    _selectedAccount = value;
    notifyListeners();
  }
}


class TradeItem {
  final String symbol;
  final String type;
  final double profit;
  final double volume;
  final double openPrice;
  final String time;
  final bool isLoss;
  final String status; // Open, Pending, Closed

  TradeItem({
    required this.symbol,
    required this.type,
    required this.profit,
    required this.volume,
    required this.openPrice,
    required this.time,
    required this.isLoss,
    required this.status,
  });
}
