import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildAndContractors extends StatelessWidget {
  static const routeName = "/build-and-contractor-screen";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: Center(
        child: Text("Build And Contractors Screen"),
      ),
    );
  }
}
