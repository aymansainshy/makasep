import 'package:makasep/src/screens/masseges_screen.dart';

import '../screens/build_and _contractor_screen.dart';
import '../screens/add_advertise_location_screen.dart';
import '../screens/add_advertise_detailes_screen.dart';
import '../screens/add_advertise_detaile2_screen.dart';
import '../screens/real_estate_detail_screen.dart';
import '../screens/add_advertise_role_screen.dart';
import '../screens/add_advertise_photo_screen.dart';
import '../screens/especial_offers_screen.dart';
import '../screens/add_advertise_screen.dart';
import '../screens/real_estates_screen.dart';
import '../screens/today_ads_screen.dart';
import '../screens/best_ads_screen.dart';
import '../screens/sign_up_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/order_screen.dart';

var routs = {
  HomeScreen.routeName: (context) => HomeScreen(),
  OrderScreen.routeName: (context) => OrderScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  BestAdsScreen.routeName: (context) => BestAdsScreen(),
  MassagesScreen.routeName: (context) => MassagesScreen(),
  TodayAdsScreen.routeName: (context) => TodayAdsScreen(),
  RealEstateScreen.routeName: (context) => RealEstateScreen(),
  AddAdvertiseScreen.routeName: (context) => AddAdvertiseScreen(),
  BuildAndContractors.routeName: (context) => BuildAndContractors(),
  EspecialOffersScreen.routeName: (context) => EspecialOffersScreen(),
  RealEstateDetailScreen.routeName: (context) => RealEstateDetailScreen(),
  AddAdvertiseRoleScreen.routeName: (context) => AddAdvertiseRoleScreen(),
  AddAdvertiseDetaileScreen.routeName: (context) => AddAdvertiseDetaileScreen(),
  AddAdvertiseDetaile2Screen.routeName: (context) =>
      AddAdvertiseDetaile2Screen(),
  AddAdvertisePhontoScreen.routeName: (context) => AddAdvertisePhontoScreen(),
  AddAdvertiseLocationScreen.routeName: (context) =>
      AddAdvertiseLocationScreen(),
};
