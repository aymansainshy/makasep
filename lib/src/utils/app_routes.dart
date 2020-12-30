import '../screens/build_and _ contractor_screen.dart';
import '../screens/real_estate_detail_screen.dart';
import '../screens/especial_offers_screen.dart';
import '../screens/add_advertise_screen.dart';
import '../screens/real_estates_screen.dart';
import '../screens/today_ads_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/sign_up_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/order_screen.dart';

var routs = {
  HomeScreen.routeName: (context) => HomeScreen(),
  OrderScreen.routeName: (context) => OrderScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  TodayAdsScreen.routeName: (context) => TodayAdsScreen(),
  FavoritesScreen.routeName: (context) => FavoritesScreen(),
  RealEstateScreen.routeName: (context) => RealEstateScreen(),
  AddAdvertiseScreen.routeName: (context) => AddAdvertiseScreen(),
  BuildAndContractors.routeName: (context) => BuildAndContractors(),
  EspecialOffersScreen.routeName: (context) => EspecialOffersScreen(),
  RealEstateDetailScreen.routeName: (context) => RealEstateDetailScreen(),
};
