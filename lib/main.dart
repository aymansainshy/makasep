import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import './src/bloc/fetch_favorite_realEstate/fetch_favorites_realestate_bloc.dart';
import './src/bloc/build_and_contractor_bloc/build_and_contract_bloc.dart';
import './src/bloc/semilar_real_estate/semilar_real_estate_bloc.dart';
import './src/bloc/real_estats_bloc/real_estats_bloc_bloc.dart';
import './src/bloc/post_favorites_realEstate/post_favorites_bloc.dart';
import './src/bloc/post_realEstate/post_realestate_bloc.dart';
import './src/providers/modifid_real_estate_provider.dart';
import './src/screens/animated_splash_screen.dart';
import './src/providers/categories_provider.dart';
import './src/repositories/real_estate_repo.dart';
import './src/providers/massages_provider.dart';
import './src/providers/auth_provider.dart';
import './src/lang/language_provider.dart';
import './src/lang/app_locelazation.dart';
import './src/screens/login_screen.dart';
import './src/screens/home_screen.dart';
import './src/utils/app_constant.dart';
import './src/utils/app_routes.dart';

void main() {
  // FetchRealEstate().fetchRealEstate(1.toString(), 1.toString(), 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
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
          value: ModifiedRealEstat(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RealEstatsBlocBloc>(
            create: (context) => RealEstatsBlocBloc(
              realEstateRepo: FetchRealEstate(),
            ),
          ),
          BlocProvider<BuildAndContractBloc>(
            create: (context) => BuildAndContractBloc(
              realEstateRepo: BuildingAndContract(),
            ),
          ),
          BlocProvider<PostFavoritesBloc>(
            create: (context) => PostFavoritesBloc(
              realEstateRepo: FavoriteRealEstatePost(),
            ),
          ),
          BlocProvider<PostRealestateBloc>(
            create: (context) => PostRealestateBloc(
              realEstateRepo: PostRealEstate(),
            ),
          ),
          BlocProvider<FetchFavoritesRealestateBloc>(
            create: (context) => FetchFavoritesRealestateBloc(
              realEstateRepo: FetchFavoritRealEState(),
            ),
          ),
          BlocProvider<SemilarRealEstateBloc>(
            create: (context) => SemilarRealEstateBloc(
              realEstateRepo: FetchSimelarRealEstate(),
            ),
          ),
        ],
        child: Consumer<LanguageProvider>(
          builder: (context, languageProvider, _) => FutureBuilder(
            future: languageProvider.fetchLocale(),
            builder: (context, snapShot) => Consumer<AuthProvider>(
              builder: (context, auth, _) => MaterialApp(
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
                  home: auth.isAuth
                      ? HomeScreen()
                      : FutureBuilder(
                          future: auth.tryAutoLogin(),
                          builder: (context, authResult) =>
                              authResult.connectionState ==
                                      ConnectionState.waiting
                                  ? Scaffold(
                                      body: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : LoginScreen(),
                        ),
                  duration: 2500,
                  type: AnimatedSplashType.StaticDuration,
                  imagePath: 'assets/images/makasep_logo.png',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
