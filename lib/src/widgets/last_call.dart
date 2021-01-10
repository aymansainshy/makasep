import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LastCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Center(
      child: Text(
        "لا يوجد تفاصيل ",
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 18,
        ),
      ),
    );
  }
}
