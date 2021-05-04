import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../screens/add_advertise_location_screen.dart';
import '../providers/auth_provider.dart';

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
    final _userData = Provider.of<AuthProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        if (!_userData.isAuth) {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Text("You Are not allowed to tap on this "),
                );
              });
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddAdvertiseLocationScreen(
                isReadOnly: true,
                target: LatLng(
                  latitude,
                  longitude,
                ),
              ),
            ),
          );
        }
      },
      child: Container(
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
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey,
                    width: 2,
                  ),
                ),
                height: 150,
                child: Image.asset(
                  "assets/images/static-image.png",
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
