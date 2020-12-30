import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAdvertiseScreen extends StatelessWidget {
  static const routeName = "/add-advertise-screen";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: Center(
        child: Text("Add Advertise Screen"),
      ),
    );
  }
}
