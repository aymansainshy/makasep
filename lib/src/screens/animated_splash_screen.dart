import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/categories_provider.dart';
import '../utils/app_constant.dart';

Widget _home;
int _duration;
String _imagePath;
AnimatedSplashType _animatedType;

enum AnimatedSplashType { StaticDuration, BackgroundProcess }

class AnimatedSplashScreen extends StatefulWidget {
  AnimatedSplashScreen({
    int duration,
    AnimatedSplashType type,
    @required Widget home,
    @required String imagePath,
  }) {
    assert(duration != null);
    assert(home != null);
    assert(imagePath != null);

    _home = home;
    _duration = duration;
    _imagePath = imagePath;
    _animatedType = type;
  }

  @override
  _AnimatedSplashState createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    if (_duration < 1000) _duration = 2000;
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.reset();
  }

  String error;

  @override
  Widget build(BuildContext context) {
    _animatedType == AnimatedSplashType.BackgroundProcess
        ? Future.delayed(Duration.zero).then((_) async {
            try {
              await Provider.of<CategoriesProvider>(context, listen: false)
                  .fetchType();

              Future.delayed(Duration(milliseconds: 1000)).then((_) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => _home));
              });
            } catch (e) {
              showDialog(
                context: context,
                builder: (context) => GestureDetector(
                  onTap: () {},
                  behavior: HitTestBehavior.opaque,
                  child: AlertDialog(
                    title: Text(
                      translate("anErrorOccurred", context),
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 12,
                      ),
                    ),
                    actions: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        child: Text(
                          "Ok",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );

              return;
            }
          })
        : Future.delayed(Duration(milliseconds: _duration)).then((_) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => _home));
          });

    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();

    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Container(
            height: isLandScape
                ? screenUtil.setHeight(2000)
                : screenUtil.setHeight(600),
            width: isLandScape
                ? screenUtil.setWidth(700)
                : screenUtil.setWidth(800),
            child: Image.asset(
              _imagePath,
              fit: isLandScape ? BoxFit.fill : BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
