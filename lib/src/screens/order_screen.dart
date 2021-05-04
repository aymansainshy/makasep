import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_constant.dart';
// import '../widgets/drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = "/order-screen";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    // ScreenUtil screenUtil = ScreenUtil();
    // var isLandScape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      key: _scaffoldKey,
      // drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "صفحة الطلبات",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Center(
        child: Text(
          "لا يوجد لديك طلبات سابقة ",
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
