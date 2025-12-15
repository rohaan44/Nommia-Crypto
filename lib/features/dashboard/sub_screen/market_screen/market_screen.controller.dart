import 'package:flutter/foundation.dart';

class MarketScreenController extends ChangeNotifier {
  final List<MarketItem> _items = marketList;

  List<MarketItem> get allItems => _items;

  List<MarketItem> get favouriteItems => _items.where((e) => e.isFav).toList();

  void toggleFavourite(MarketItem item) {
    item.isFav = !item.isFav;
    notifyListeners();
  }
}

class MarketItem {
  final String pair;
  final String bid;
  final String ask;
  final double change;
  bool isFav;

  MarketItem({
    required this.pair,
    required this.bid,
    required this.ask,
    required this.change,
    required this.isFav,
  });
}

List<MarketItem> marketList = [
  MarketItem(
    pair: "EUR/USD",
    bid: "1.0854",
    ask: "1.0856",
    change: 0.21,
    isFav: true,
  ),
  MarketItem(
    pair: "BTC/USD",
    bid: "68,500",
    ask: "68,520",
    change: -0.32,
    isFav: false,
  ),
  MarketItem(
    pair: "XAU/USD",
    bid: "1.0854",
    ask: "1.0856",
    change: 0.21,
    isFav: true,
  ),
  MarketItem(
    pair: "USD/JPY",
    bid: "68,500",
    ask: "68,520",
    change: -0.32,
    isFav: false,
  ),
  MarketItem(
    pair: "EUR/USD",
    bid: "1.0854",
    ask: "1.0856",
    change: 0.21,
    isFav: true,
  ),
  MarketItem(
    pair: "BTC/USD",
    bid: "68,500",
    ask: "68,520",
    change: -0.32,
    isFav: false,
  ),
  MarketItem(
    pair: "XAU/USD",
    bid: "1.0854",
    ask: "1.0856",
    change: 0.21,
    isFav: true,
  ),
  MarketItem(
    pair: "USD/JPY",
    bid: "68,500",
    ask: "68,520",
    change: -0.32,
    isFav: false,
  ),
  MarketItem(
    pair: "EUR/USD",
    bid: "1.0854",
    ask: "1.0856",
    change: 0.21,
    isFav: true,
  ),
  MarketItem(
    pair: "BTC/USD",
    bid: "68,500",
    ask: "68,520",
    change: -0.32,
    isFav: false,
  ),
  MarketItem(
    pair: "XAU/USD",
    bid: "1.0854",
    ask: "1.0856",
    change: 0.21,
    isFav: true,
  ),
  MarketItem(
    pair: "USD/JPY",
    bid: "68,500",
    ask: "68,520",
    change: -0.32,
    isFav: false,
  ),
];
