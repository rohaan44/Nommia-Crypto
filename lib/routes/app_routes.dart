import 'package:flutter/cupertino.dart';
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

         default:
        return CupertinoPageRoute(
          builder: (context) => Container(),
        );
    }}}