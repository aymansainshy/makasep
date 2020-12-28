import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationOnMap extends StatelessWidget {
  final bool isLandScape;
  final ScreenUtil screenUtil;

  const LocationOnMap({Key key, this.isLandScape, this.screenUtil})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Location On Map",
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize:
                    isLandScape ? screenUtil.setSp(20) : screenUtil.setSp(50),
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 5),
            Container(
              height: 150,
              color: Colors.blueGrey,
            )
          ],
        ),
      ),
    );
  }
}
