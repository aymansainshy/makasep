import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescriptionText extends StatelessWidget {
  final bool isLandScape;
  final ScreenUtil screenUtil;

  const DescriptionText({
    Key key,
    @required this.isLandScape,
    @required this.screenUtil,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "المواصفات",
            style: TextStyle(
              color: Colors.grey.shade900,
              fontWeight: FontWeight.bold,
              fontSize:
                  isLandScape ? screenUtil.setSp(25) : screenUtil.setSp(45),
              letterSpacing: 1,
            ),
          ),
          Text(
            "غرف نوم 3 , و 3 مطبخ وصالة , و4 حمامات , مكيفات هواء 5",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize:
                  isLandScape ? screenUtil.setSp(20) : screenUtil.setSp(35),
            ),
          ),
        ],
      ),
    );
  }
}
