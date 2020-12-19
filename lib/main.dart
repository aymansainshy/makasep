import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './src/providers/categories_provider.dart';
import './src/utils/app_routes.dart';
import './src/utils/app_constant.dart';
import './src/screens/animated_splash_screen.dart';
import './src/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CategoriesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Makasep App',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        routes: routs,
        home: AnimatedSplashScreen(
          home: LoginScreen(),
          duration: 2500,
          type: AnimatedSplashType.StaticDuration,
          imagePath: 'assets/images/makasep_logo.png',
        ),
      ),
    );
  }
}
