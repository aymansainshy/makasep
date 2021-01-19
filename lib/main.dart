import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import './src/providers/massages_provider.dart';
import './src/providers/categories_provider.dart';
import './src/utils/app_routes.dart';
import './src/utils/app_constant.dart';
import './src/lang/language_provider.dart';
import './src/lang/app_locelazation.dart';
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
          value: LanguageProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CategoriesProvider(),
        ),
        ChangeNotifierProvider.value(
          value: MassagesProvider(),
        ),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, _) => FutureBuilder(
          future: languageProvider.fetchLocale(),
          builder: (context, snapShot) => MaterialApp(
            title: 'Makasep App',
            debugShowCheckedModeBanner: false,
            locale: languageProvider.appLocal,
            supportedLocales: [
              Locale('en', 'US'),
              Locale('ar', 'SA'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            theme: appTheme,
            routes: routs,
            home: AnimatedSplashScreen(
              home: LoginScreen(),
              duration: 2500,
              type: AnimatedSplashType.StaticDuration,
              imagePath: 'assets/images/makasep_logo.png',
            ),
          ),
        ),
      ),
    );
  }
}
