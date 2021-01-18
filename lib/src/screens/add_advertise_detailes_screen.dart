import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/categories_provider.dart';
import '../screens/add_advertise_detaile2_screen.dart';
import '../utils/app_constant.dart';

class AddAdvertiseDetaileScreen extends StatefulWidget {
  static const routeName = "/add-advertise-detaile-screen";

  @override
  _AddAdvertiseDetaileScreenState createState() =>
      _AddAdvertiseDetaileScreenState();
}

class _AddAdvertiseDetaileScreenState extends State<AddAdvertiseDetaileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  double hallCount = 1;
  double bathRoomCount = 1;
  double roomCount = 1;
  double stepsCount = 1;
  double realStateOldCount = 1;
  bool mafrosha = false; //mafroshaa
  bool ketchen = false;
  bool parking = false;
  bool elevator = false; //misaad - asanser
  bool airConditioner = false;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      // drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "4 اضافة اعلان",
          style: TextStyle(fontSize: 15),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        height:
            isLandScape ? screenUtil.setHeight(230) : screenUtil.setHeight(150),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: AppColors.primaryColor,
          textColor: Colors.white,
          child: Text(
            "استمرار",
            style: TextStyle(
              fontSize:
                  isLandScape ? screenUtil.setSp(25) : screenUtil.setSp(45),
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(AddAdvertiseDetaile2Screen.routeName);
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawSlider(
                text: "الصالات",
                isLandScape: isLandScape,
                screenUtil: screenUtil,
                counter: hallCount,
              ),
              DrawSlider(
                text: "عدد دورات المياه",
                isLandScape: isLandScape,
                screenUtil: screenUtil,
                counter: bathRoomCount,
              ),
              DrawSlider(
                text: "الغرف",
                isLandScape: isLandScape,
                screenUtil: screenUtil,
                counter: roomCount,
              ),
              DrawSlider(
                text: "الدور",
                isLandScape: isLandScape,
                screenUtil: screenUtil,
                counter: stepsCount,
              ),
              DrawSlider(
                text: "عمر العقار اقل من ",
                isLandScape: isLandScape,
                screenUtil: screenUtil,
                counter: realStateOldCount,
              ),
              DrawSwitcher(
                text: "مفروشة",
                isLandScape: isLandScape,
                screenUtil: screenUtil,
                boolStatus: mafrosha,
              ),
              DrawSwitcher(
                text: "مطبخ",
                isLandScape: isLandScape,
                screenUtil: screenUtil,
                boolStatus: ketchen,
              ),
              DrawSwitcher(
                  text: "مدخل سيارة",
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  boolStatus: parking),
              DrawSwitcher(
                text: "مكيفات هواء",
                isLandScape: isLandScape,
                screenUtil: screenUtil,
                boolStatus: airConditioner,
              ),
              DrawSwitcher(
                text: "مصعد + ${elevator.toString()}",
                isLandScape: isLandScape,
                screenUtil: screenUtil,
                boolStatus: elevator,
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DrawSwitcher extends StatefulWidget {
  DrawSwitcher({
    Key key,
    @required this.isLandScape,
    @required this.screenUtil,
    @required this.boolStatus,
    @required this.text,
  }) : super(key: key);

  final ScreenUtil screenUtil;
  final bool isLandScape;
  bool boolStatus;
  final String text;

  @override
  _DrawSwitcherState createState() => _DrawSwitcherState();
}

class _DrawSwitcherState extends State<DrawSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Transform.translate(
          offset: Offset(-15, 0),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: widget.isLandScape
                  ? widget.screenUtil.setSp(20)
                  : widget.screenUtil.setSp(40),
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(10, 0),
          child: Switch.adaptive(
            value: widget.boolStatus,
            onChanged: (value) {
              setState(() {
                widget.boolStatus = value;
              });
            },
          ),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class DrawSlider extends StatefulWidget {
  DrawSlider({
    Key key,
    @required this.isLandScape,
    @required this.screenUtil,
    @required this.counter,
    @required this.text,
  }) : super(key: key);

  final bool isLandScape;
  final ScreenUtil screenUtil;
  double counter;
  final String text;

  @override
  _DrawSliderState createState() => _DrawSliderState();
}

class _DrawSliderState extends State<DrawSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Transform.translate(
          offset: Offset(-12, 0),
          child: Row(
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: widget.isLandScape
                      ? widget.screenUtil.setSp(20)
                      : widget.screenUtil.setSp(40),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(width: 10),
              Text(
                "${widget.counter.toInt()}",
                style: TextStyle(
                  fontSize: widget.isLandScape
                      ? widget.screenUtil.setSp(20)
                      : widget.screenUtil.setSp(40),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 3,
            activeTrackColor: AppColors.primaryColor,
            inactiveTrackColor: Colors.grey[300],
            thumbColor: Colors.green,
            minThumbSeparation: 100,
            rangeThumbShape: RoundRangeSliderThumbShape(
              enabledThumbRadius: 10,
              disabledThumbRadius: 10,
            ),
          ),
          child: Slider.adaptive(
            label: widget.counter.toInt().toString(),
            value: widget.counter,
            min: 1,
            max: 10,
            divisions: 10,
            onChanged: (value) {
              setState(() {
                widget.counter = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
