import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_constant.dart';
import '../screens/add_advertise_screen.dart';
// import '../widgets/drawer.dart';

class AddAdvertiseRoleScreen extends StatelessWidget {
  static const routeName = "/add-advertise-role-screen";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      key: _scaffoldKey,
      // drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "شروط اضافة اعلان",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    _buildRow(
                      screenUtil: screenUtil,
                      text:
                          "سيتم ايقاف العضوية في حال مخالفة الشروط دون سابق انذار",
                    ),
                    SizedBox(height: 2),
                    _buildRow(
                      screenUtil: screenUtil,
                      text: "اغلاق الاعلان بعد الإيجار او البيع",
                    ),
                    SizedBox(height: 2),
                    _buildRow(
                      screenUtil: screenUtil,
                      text: "الاكتفاء بخاصية التحديث وعدم التكرار",
                    ),
                    SizedBox(height: 2),
                    _buildRow(
                      screenUtil: screenUtil,
                      text: "الدقة في الموقع والمصداقية في معلومات الاعلان",
                    ),
                    SizedBox(height: 2),
                    _buildRow(
                      screenUtil: screenUtil,
                      text: "ارافق صور فعلية للعقار وليس نمازج او مخططات",
                    ),
                    SizedBox(height: 2),
                    _buildRow(
                      screenUtil: screenUtil,
                      text: "تحديد السعر اجباري فالموقع لا يقبل السوم",
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: isLandScape
                ? screenUtil.setHeight(230)
                : screenUtil.setHeight(180),
            padding: EdgeInsets.all(8),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: AppColors.primaryColor,
              textColor: Colors.white,
              child: Text(
                "موافق",
                style: TextStyle(
                  fontSize:
                      isLandScape ? screenUtil.setSp(25) : screenUtil.setSp(40),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AddAdvertiseScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }

  Row _buildRow({ScreenUtil screenUtil, String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.translate(
          offset: Offset(0, 8),
          child: CircleAvatar(
            radius: 6,
            backgroundColor: AppColors.primaryColor,
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: Container(
            child: Text(
              text,
              textAlign: TextAlign.start,
              style: TextStyle(
                letterSpacing: 1,
                fontSize: screenUtil.setSp(40),
              ),
            ),
          ),
        )
      ],
    );
  }
}
