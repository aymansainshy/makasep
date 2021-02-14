import 'package:flutter/material.dart';
import '../repositories/google_map_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationOnMap extends StatelessWidget {
  final bool isLandScape;
  final ScreenUtil screenUtil;
  final double latitude;
  final double longitude;

  const LocationOnMap({
    Key key,
    this.isLandScape,
    this.screenUtil,
    this.latitude,
    this.longitude,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "الموقع على الخريطة",
              style: TextStyle(
                color: Colors.grey.shade900,
                fontWeight: FontWeight.bold,
                fontSize:
                    isLandScape ? screenUtil.setSp(20) : screenUtil.setSp(45),
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 5),
            // 37.4447, -121.7910
            Container(
              height: 150,
              color: Colors.blueGrey,
              child: Image.network(
                // 15.555449, 32.563770
                GoogleServicesApi.genarateLocationImage(
                  latitude: 37.43296265331129,
                  longitude: -122.08832357078792,
                ),
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
