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
            "Descroption",
            style: TextStyle(
              color: Colors.grey.shade900,
              fontSize:
                  isLandScape ? screenUtil.setSp(25) : screenUtil.setSp(50),
              letterSpacing: 1,
            ),
          ),
          Text(
            "khartoum 2 , its awesome tools that alow you to convert text to accual machine , you know what's funny about you , yout are so smart and that is why i love you so much ",
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
