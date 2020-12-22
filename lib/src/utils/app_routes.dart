import '../screens/real_estate_detail_screen.dart';
import '../screens/real_estates_screen.dart';
import '../screens/sign_up_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';

var routs = {
  HomeScreen.routeName: (context) => HomeScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  RealEstateScreen.routeName: (context) => RealEstateScreen(),
  RealEstateDetailScreen.routeName: (context) => RealEstateDetailScreen(),
};
