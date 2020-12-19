import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RealEstateScreen extends StatelessWidget {
  static const routeName = "/real-estate-screen";
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: Text("Real Estates"),
      ),
      body: Center(
        child: Text("Real Estate Screen"),
      ),
    );
  }
}
