import 'package:flutter/material.dart';

class BankTransferController extends ChangeNotifier {
  final ibanController = TextEditingController();
  final swiftController = TextEditingController();
  final bankNameController = TextEditingController();
  final bankDetails = {
    "Bank Name": "XYZ Bank",
    "Account holder": "Nommia Financial Services",
    "IBAN": "XXXX-XXXX-XXXX",
    "SWIFT CODE": "XXXXXXX",
    "Reference Code": "NOM-USD-8756XQ629",
  };
}
