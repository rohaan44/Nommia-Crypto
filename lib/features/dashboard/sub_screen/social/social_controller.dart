import 'package:flutter/material.dart';

class SocialController extends ChangeNotifier {
  // --- Dummy Data for UI ---
  final List<TradeIdea> tradeIdeas = [
    TradeIdea(
      title: "Bullish Reversal",
      author: "Andrej V.",
      date: "11 Nov 2025",
      assetClass: "Stocks",
      assetName: "TSLA",
      description: "Potential bullish reversal...",
      entryPrice: "1.0700",
      stopLoss: "1.0650",
      tp1: "1.0780",
      tp2: "1.0850",
      tp3: "1.0950",
      riskReward: "1 : 2.4",
      note: "Wait for confirmation...",
    ),
    TradeIdea(
      title: "RSI Divergence",
      author: "Sarah J.",
      date: "10 Nov 2025",
      assetClass: "Forex",
      assetName: "EURUSD",
      description: "RSI indicating overbought...",
      entryPrice: "1.0820",
      stopLoss: "1.0880",
      tp1: "1.0750",
      tp2: "1.0700",
      tp3: "1.0600",
      riskReward: "1 : 3.0",
      note: "Enter on break...",
    ),
    TradeIdea(
      title: "Breakout",
      author: "Mike T.",
      date: "12 Nov 2025",
      assetClass: "Crypto",
      assetName: "BTC",
      description: "Testing resistance...",
      entryPrice: "90000",
      stopLoss: "88000",
      tp1: "95000",
      tp2: "100000",
      tp3: "105000",
      riskReward: "1 : 5.0",
      note: "HODL...",
    ),
  ];

  final List<SocialStrategy> copyTraders = [
    SocialStrategy(
      name: "Alpha FX Growth",
      roi: "+32%",
      capital: "\$45,000",
      fee: "30% / 70%",
      minDeposit: "\$500",
      isSubscribed: true,
    ),
    SocialStrategy(
      name: "Alpha FX Growth",
      roi: "+15%",
      capital: "\$12,000",
      fee: "20% / 80%",
      minDeposit: "\$100",
      isSubscribed: false,
    ),
  ];

  final List<SocialStrategy> pammAccounts = [
    SocialStrategy(
      name: "Master Yield",
      roi: "+12%",
      capital: "\$150,000",
      fee: "40% / 60%",
      minDeposit: "\$1000",
      isSubscribed: true,
    ),
    SocialStrategy(
      name: "Safe Haven",
      roi: "+5%",
      capital: "\$500,000",
      fee: "10% / 90%",
      minDeposit: "\$2000",
      isSubscribed: false,
    ),
  ];

  // --- Funds Sheet State ---
  String _selectedAccount = "Account Name";
  double _allocatedFunds = 5000.00;
  double _amountInput = 0.0;

  String get selectedAccount => _selectedAccount;
  double get allocatedFunds => _allocatedFunds;
  double get amountInput => _amountInput;

  void setAmount(String val) {
    _amountInput = double.tryParse(val) ?? 0.0;
    notifyListeners();
  }
}

class TradeIdea {
  final String title;
  final String author;
  final String date;
  final String assetClass;
  final String assetName;
  final String description;
  final String entryPrice;
  final String stopLoss;
  final String tp1;
  final String tp2;
  final String tp3;
  final String riskReward;
  final String note;

  TradeIdea({
    required this.title,
    required this.author,
    required this.date,
    required this.assetClass,
    required this.assetName,
    required this.description,
    required this.entryPrice,
    required this.stopLoss,
    required this.tp1,
    required this.tp2,
    required this.tp3,
    required this.riskReward,
    required this.note,
  });
}

class SocialStrategy {
  final String name;
  final String roi;
  final String capital;
  final String fee;
  final String minDeposit;
  final bool isSubscribed;

  SocialStrategy({
    required this.name,
    required this.roi,
    required this.capital,
    required this.fee,
    required this.minDeposit,
    required this.isSubscribed,
  });
}
