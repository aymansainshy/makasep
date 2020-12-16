import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    var _isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();

    return Scaffold(
      body: Container(
        height: mediaQuery.height,
        width: mediaQuery.width,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(top: 30),
                padding: _isLandScape
                    ? EdgeInsets.only(top: 10)
                    : EdgeInsets.only(top: 40),
                // color: Colors.red,
                height: _isLandScape
                    ? screenUtil.setHeight(1200)
                    : screenUtil.setHeight(900),
                width: _isLandScape
                    ? screenUtil.setWidth(1000)
                    : screenUtil.setWidth(1000),
                child: Image.asset(
                  "assets/images/makasep_logo.png",
                  fit: _isLandScape ? BoxFit.contain : BoxFit.cover,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -25),
              child: Text(
                "We well never let you down ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: _isLandScape
                      ? screenUtil.setSp(30)
                      : screenUtil.setSp(45),
                ),
              ),
            ),
            Spacer(),
            CircularProgressIndicator(
              backgroundColor: Colors.grey,
              strokeWidth: 2.0,
            ),
            SizedBox(
              height: screenUtil.setHeight(150),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          color: Colors.green,
        ),
      ),
    );
  }
}
