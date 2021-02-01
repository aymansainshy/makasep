import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:makasep/src/bloc/real_estats_bloc/real_estats_bloc_bloc.dart';
import 'package:makasep/src/repositories/real_estate_repo.dart';
import './src/providers/massages_provider.dart';
import './src/providers/categories_provider.dart';
import './src/utils/app_routes.dart';
import './src/utils/app_constant.dart';
import './src/lang/language_provider.dart';
import './src/lang/app_locelazation.dart';
import './src/screens/animated_splash_screen.dart';
import './src/screens/login_screen.dart';
import './src/providers/real_states_provider.dart';

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
        ChangeNotifierProvider.value(
          value: RealStatesProvider(),
        ),
      ],
      child: BlocProvider(
        create: (context) =>
            RealEstatsBlocBloc(realEstateRepo: RealEstateRepo()),
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
      ),
    );
  }
}
