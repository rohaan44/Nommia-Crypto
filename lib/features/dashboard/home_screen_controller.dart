import 'package:flutter/widgets.dart';

class DashBoardScreenController with ChangeNotifier {
  final TextEditingController searchFieldController = TextEditingController();
  int selectedIndex = 0;

  void onBottomNavTap(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
