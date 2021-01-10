import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'real_estate_item.dart';

class BestAds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 4,
        right: 4,
      ),
      child: ListView.builder(
        itemCount: 12,
        itemBuilder: (context, i) => RealEstateItem(
          screenUtil: screenUtil,
          isLandScape: isLandScape,
        ),
      ),
    );
  }
}
