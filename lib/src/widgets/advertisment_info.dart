import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_constant.dart';

class AdvertisInfo extends StatelessWidget {
  final bool isLandScape;
  final ScreenUtil screenUtil;

  const AdvertisInfo({
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
            "معلومات المعلن",
            style: TextStyle(
              color: Colors.grey.shade900,
              fontWeight: FontWeight.bold,
              fontSize:
                  isLandScape ? screenUtil.setSp(25) : screenUtil.setSp(45),
              letterSpacing: 1,
            ),
          ),
          Card(
            elevation: 5,
            child: Container(
              // color: Colors.red,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Ayman Sainshy",
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontSize: isLandScape
                                  ? screenUtil.setSp(25)
                                  : screenUtil.setSp(35),
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            "+249924081893",
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontSize: isLandScape
                                  ? screenUtil.setSp(25)
                                  : screenUtil.setSp(35),
                              letterSpacing: 1,
                            ),
                          ),
                          RaisedButton(
                            color: AppColors.primaryColor,
                            onPressed: () {},
                            child: Text(
                              "محادثة",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isLandScape
                                    ? screenUtil.setSp(25)
                                    : screenUtil.setSp(30),
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: screenUtil.setHeight(260),
                      child: Image.asset(
                        "assets/images/sudan.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
