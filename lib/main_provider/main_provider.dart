import 'package:nommia_crypto/features/auth/forget_password/forget_password_controller.dart';
import 'package:nommia_crypto/features/auth/sign_in/sign_in_controller.dart';
import 'package:nommia_crypto/features/auth/sign_up/sign_up_controller.dart';
import 'package:nommia_crypto/features/dashboard/home_screen_controller.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/account_screen/account_screen_controller.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/social/social_controller.dart';
import 'package:nommia_crypto/features/splash_screen/splash_screen_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providersList = [
  ChangeNotifierProvider(create: (context) => SplashScreenController()),
  ChangeNotifierProvider(create: (context) => DashBoardScreenController()),
  ChangeNotifierProvider(create: (context) => AccountScreenController()),
  ChangeNotifierProvider(create: (context) => SignInController()),
  ChangeNotifierProvider(create: (context) => SignUpController()),
  ChangeNotifierProvider(create: (context) => ForgetPasswordController()),
  ChangeNotifierProvider(create: (context) => SocialController()),
];
