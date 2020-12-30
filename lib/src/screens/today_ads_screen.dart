import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodayAdsScreen extends StatelessWidget {
  static const routeName = "/today-ads-screen";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: Center(
        child: Text("Today Ads Screen"),
      ),
    );
  }
}
