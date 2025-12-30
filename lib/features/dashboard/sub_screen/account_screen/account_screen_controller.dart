import 'package:flutter/widgets.dart';
import 'package:nommia_crypto/utils/asset_utils.dart';

class AccountScreenController with ChangeNotifier {
 
final walletController = TextEditingController();
  String? _selectedLabel;

  String? get selectedLabel => _selectedLabel;
  set selectedLabel(String? value) {
    _selectedLabel = value;
    notifyListeners();
  }

  String? _selectedWallet;

  String? get selectedWallet => _selectedWallet;
  set selectedWallet(String? value) {
    _selectedWallet = value;
    notifyListeners();
  }

 

  String? _selectedWithdrawCurrency;

  String? get selectedWithdrawCurrency => _selectedWithdrawCurrency;
  set selectedWithdrawCurrency(String? value) {
    _selectedWithdrawCurrency = value;
    notifyListeners();
  }

  String? _selectedNetwork;

  String? get selectedNetwork => _selectedNetwork;
  set selectedNetwork(String? value) {
    _selectedNetwork = value;
    notifyListeners();
  }

  int? _selectIndex;

  int? get selectIndex => _selectIndex;
  set selectIndex(int? value) {
    _selectIndex = value;
    notifyListeners();
  }

  bool _isCrypto = true;

  bool get isCrypto => _isCrypto;
  set isCrypto(bool value) {
    _isCrypto = value;
    notifyListeners();
  }

  bool _isFiat = false;

  bool? get isFiat => _isFiat;
  set isFiat(bool value) {
    _isFiat = value;
    notifyListeners();
  }

  final accountList = ["Account #1", "Account #2", "Account #3", "Account #4"];

  String? _selectedAccount;

  String? get selectedAccount => _selectedAccount;
  set selectedAccount(String? value) {
    _selectedAccount = value;
    notifyListeners();
  }

final currencyList = ["\$ (USD)", "€ (EUR)", "£ (GBP)"];

  String? _selectedCurrency;

  String? get selectedCurrency => _selectedCurrency;
  set selectedCurrency(String? value) {
    _selectedCurrency = value;
    notifyListeners();
  }



  final dataList = [
    {"key": "Profit & Loss", "value": "\$1,200.00"},
    {"key": "Equity", "value": "\$13,700.00"},
    {"key": "Margin %", "value": "43.79%"},
    {"key": "Margin used", "value": "\$6,000.00"},
    {"key": "Margin Available", "value": "\$7,700.00"},
  ];
  final btnList = [
    {"img": AssetUtils.arrowDeposit, "title": "Deposit"},
    {"img": AssetUtils.arrowWithdra, "title": "Withdraw"},
    {"img": AssetUtils.arrowTransfer, "title": "Transfer"},
  ];
final countryList = ["United Arab Emirates", "United Kingdom", "Uruguay"];

   String? _selectedCountry;
  String? get selectedCountry => _selectedCountry;
  set selectedCountry(String? value) {
    _selectedCountry = value;
    notifyListeners();
  }
  final cryptoList = ["USDC - ERC20", "USDT - TRC20", "BTC", "XRP"];

  String _selectedCrypto = "USDC - ERC20";

  String get selectedCrypto => _selectedCrypto;
  set selectedCrypto(String value) {
    _selectedCrypto = value;
    notifyListeners();
  }
}
