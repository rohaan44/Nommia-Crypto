import 'package:flutter/material.dart';
import 'package:nommia_crypto/main_provider/main_provider.dart';
import 'package:nommia_crypto/routes/app_routes.dart';
import 'package:nommia_crypto/routes/route_paths.dart';
import 'package:nommia_crypto/utils/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await CacheService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providersList,
      child: Sizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            title: 'Nommia Crypto',
            theme: AppTheme.darkTheme,
            // home:const HomeScreen(),
            initialRoute: RoutePaths.splashScreen,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.generateRoute,
          );
        },
      ),
    );
  }
}
