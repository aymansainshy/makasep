import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/masseges_screen.dart';
import '../utils/app_constant.dart';

class ChatsScreen extends StatelessWidget {
  static const routeName = "/chats-screen";
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(MassagesScreen.routeName);
            },
            child: Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              color: AppColors.primaryColor,
              height: 100,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }
}
