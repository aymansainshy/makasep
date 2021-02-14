import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

import '../providers/categories_provider.dart';
import '../providers/modifid_real_estate_provider.dart';
import '../screens/add_advertise_detailes_screen.dart';
import '../utils/app_constant.dart';

class AddAdvertiseLocationScreen extends StatelessWidget {
  static const routeName = "/add-advertise-location-screen";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final Map<String, dynamic> address = {
    "lan": 4442432.334,
    "lat": 223.3341414,
  };

  Future<void> _getCurrentUserLocation() async {
    final locationData = await Location().getLocation();
    print(locationData.latitude);
    print(locationData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      // drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Provider.of<ModifiedRealEstat>(context, listen: false)
              .setAdderess(address);
          Navigator.of(context).pushNamed(AddAdvertiseDetaileScreen.routeName);
        },
        child: Text("استمرار"),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "3 اضافة اعلان",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Container(
        color: Colors.blueAccent,
        child: Center(
          child: Text(
            "اضافة موقع للاعلان من الخريطة ",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
