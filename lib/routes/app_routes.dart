import 'package:flutter/cupertino.dart';
import 'package:nommia_crypto/features/auth/forget_password/forget_password.dart';
import 'package:nommia_crypto/features/auth/sign_in/sign_in.dart';
import 'package:nommia_crypto/features/auth/sign_up/sign_up.dart';
import 'package:nommia_crypto/features/dashboard/dashboard_screen.dart';
import 'package:nommia_crypto/features/splash_screen/splash_screen.dart';
import 'package:nommia_crypto/routes/route_paths.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Walkthrougn screens
      case RoutePaths.splashScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const SplashScreen();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );

      case RoutePaths.dashboardScreem:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return DashBoardScreen();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
      case RoutePaths.signIn:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SignIn();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
      case RoutePaths.signUp:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SignUp();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
      case RoutePaths.forgetPassword:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return ForgetPassword();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );

      default:
        return CupertinoPageRoute(builder: (context) => Container());
    }
  }
}
