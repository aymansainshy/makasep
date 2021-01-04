import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_constant.dart';
import '../widgets/drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = "/order-screen";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text("OrderScreen Screen"),
      ),
      body: Center(
        child: Text("OrderScreen Screen"),
      ),
    );
  }
}
