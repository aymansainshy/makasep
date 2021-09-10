import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_constant.dart';
import '../widgets/best_ads.dart';
import '../widgets/last_call.dart';
// import '../widgets/drawer.dart';

class TodayAdsScreen extends StatelessWidget {
  static const routeName = "/today-ads-screen";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final List<Widget> _tabBarView = [
      BestAds(),
      LastCall(),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        // drawer: AppDrawer(),
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "إعلانات اليوم",
            style: TextStyle(fontSize: 15),
          ),
          bottom: TabBar(
            indicatorColor: AppColors.primaryColor,
            labelColor: Colors.white,
            labelStyle: TextStyle(
              fontSize:
                  isLandScape ? screenUtil.setSp(25) : screenUtil.setSp(45),
              // fontFamily: "cairo",
            ),
            tabs: [
              Tab(text: "إعلانات اليوم"),
              Tab(text: "المكالمات الاخيرة"),
            ],
          ),
        ),
        body: TabBarView(
          children: _tabBarView,
        ),
      ),
    );
  }
}
