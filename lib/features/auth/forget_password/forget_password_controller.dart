import 'package:flutter/material.dart';

class ForgetPasswordController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ForgetPasswordController() {
    emailController.addListener(_onFieldChanged);
    passwordController.addListener(_onFieldChanged);
  }
  bool _isPassHide = true;

  bool get isPassHide => _isPassHide;
  set isPassHide(bool value) {
    _isPassHide = value;
    notifyListeners();
  }

  /// Trigger UI update on any field edit
  void _onFieldChanged() {
    notifyListeners();
  }

  /// Email Validation
  bool get isEmailValid {
    final email = emailController.text.trim();
    return email.contains("@") && email.contains(".");
  }

  /// Password Validation
  bool get isPasswordValid {
    return passwordController.text.trim().length >= 6;
  }

  /// Combined Validation
  bool get isFormValid {
    return isEmailValid && isPasswordValid;
  }

  /// Dispose properly
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
