import 'package:flutter/material.dart';

class CreditTransferController extends ChangeNotifier {
  final cardNumberController = TextEditingController();
  final expirationController = TextEditingController();
  final cvcController = TextEditingController();
  final holderNameController = TextEditingController();

  bool _isExpirationVisible = false;
  bool get isExpirationVisible => _isExpirationVisible;
  set isExpirationVisible(bool value) {
    _isExpirationVisible = value;
    notifyListeners();
  }

  bool _isCvcVisible = false;
  bool get isCvcVisible => _isCvcVisible;
  set isCvcVisible(bool value) {
    _isCvcVisible = value;
    notifyListeners();
  }
}
