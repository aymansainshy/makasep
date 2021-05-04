import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/modifid_real_estate_provider.dart';
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
          child: Consumer<ModifiedRealEstat>(
            builder: (context, realEstateProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawSlider(
                    text: "الصالات",
                    isLandScape: isLandScape,
                    screenUtil: screenUtil,
                    counter:
                        realEstateProvider.reatEstate.details.hall.toDouble(),
                    func: (double value) {
                      realEstateProvider.changHalls(value.toInt());
                    },
                  ),
                  DrawSlider(
                    text: "عدد دورات المياه",
                    isLandScape: isLandScape,
                    screenUtil: screenUtil,
                    counter: realEstateProvider.reatEstate.details.bathroom
                        .toDouble(),
                    func: (double value) {
                      realEstateProvider.setBathRooms(value.toInt());
                    },
                  ),
                  DrawSlider(
                    text: "الغرف",
                    isLandScape: isLandScape,
                    screenUtil: screenUtil,
                    counter:
                        realEstateProvider.reatEstate.details.rooms.toDouble(),
                    func: (double value) {
                      realEstateProvider.changRooms(value.toInt());
                    },
                  ),
                  DrawSliderFloor(
                    text: "الدور",
                    isLandScape: isLandScape,
                    screenUtil: screenUtil,
                    counter:
                        realEstateProvider.reatEstate.details.steps.toDouble(),
                    func: (double value) {
                      realEstateProvider.setSteps(value.toInt());
                    },
                  ),
                  DrawSlider(
                    text: "عمر العقار اقل من ",
                    isLandScape: isLandScape,
                    screenUtil: screenUtil,
                    counter:
                        realEstateProvider.reatEstate.details.old.toDouble(),
                    func: (double value) {
                      realEstateProvider.setOld(value.toInt());
                    },
                  ),
                  DrawSwitcher(
                    text: "مفروشة",
                    isLandScape: isLandScape,
                    screenUtil: screenUtil,
                    boolStatus: realEstateProvider.reatEstate.details.mafrosha,
                    func: (bool value) {
                      realEstateProvider.isMafroshe(value);
                    },
                  ),
                  DrawSwitcher(
                    text: "مطبخ",
                    isLandScape: isLandScape,
                    screenUtil: screenUtil,
                    boolStatus: realEstateProvider.reatEstate.details.ketchen,
                    func: (bool value) {
                      realEstateProvider.isKetchen(value);
                    },
                  ),
                  DrawSwitcher(
                    text: "مدخل سيارة",
                    isLandScape: isLandScape,
                    screenUtil: screenUtil,
                    boolStatus: realEstateProvider.reatEstate.details.parking,
                    func: (bool value) {
                      realEstateProvider.isParking(value);
                    },
                  ),
                  DrawSwitcher(
                    text: "مكيفات هواء",
                    isLandScape: isLandScape,
                    screenUtil: screenUtil,
                    boolStatus:
                        realEstateProvider.reatEstate.details.airConditioner,
                    func: (bool value) {
                      realEstateProvider.isAirConditions(value);
                    },
                  ),
                  DrawSwitcher(
                    text:
                        "مصعد + ${realEstateProvider.reatEstate.details.elevator}",
                    isLandScape: isLandScape,
                    screenUtil: screenUtil,
                    boolStatus: realEstateProvider.reatEstate.details.elevator,
                    func: (bool value) {
                      realEstateProvider.isElevator(value);
                    },
                  ),
                  SizedBox(height: 5),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DrawSwitcher extends StatelessWidget {
  DrawSwitcher({
    Key key,
    @required this.isLandScape,
    @required this.screenUtil,
    @required this.boolStatus,
    @required this.text,
    @required this.func,
  }) : super(key: key);

  final ScreenUtil screenUtil;
  final bool isLandScape;
  bool boolStatus;
  final String text;
  final func;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Transform.translate(
          offset: Offset(-15, 0),
          child: Text(
            text,
            style: TextStyle(
              fontSize:
                  isLandScape ? screenUtil.setSp(20) : screenUtil.setSp(40),
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(10, 0),
          child: Switch.adaptive(
            value: boolStatus,
            onChanged: func,
          ),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class DrawSlider extends StatelessWidget {
  DrawSlider({
    Key key,
    @required this.isLandScape,
    @required this.screenUtil,
    @required this.counter,
    @required this.text,
    @required this.func,
  }) : super(key: key);

  final bool isLandScape;
  final ScreenUtil screenUtil;
  double counter;
  final String text;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Transform.translate(
          offset: Offset(-12, 0),
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize:
                      isLandScape ? screenUtil.setSp(20) : screenUtil.setSp(40),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(width: 10),
              Text(
                "${counter.toInt()}",
                style: TextStyle(
                  fontSize:
                      isLandScape ? screenUtil.setSp(20) : screenUtil.setSp(40),
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
            label: counter.toInt().toString(),
            value: counter,
            min: 1,
            max: 10,
            divisions: 10,
            onChanged: func,
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class DrawSliderFloor extends StatelessWidget {
  DrawSliderFloor({
    Key key,
    @required this.isLandScape,
    @required this.screenUtil,
    @required this.counter,
    @required this.text,
    @required this.func,
  }) : super(key: key);

  final bool isLandScape;
  final ScreenUtil screenUtil;
  double counter;
  final String text;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Transform.translate(
          offset: Offset(-12, 0),
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize:
                      isLandScape ? screenUtil.setSp(20) : screenUtil.setSp(40),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(width: 10),
              Text(
                "${counter.toInt() - 1}",
                style: TextStyle(
                  fontSize:
                      isLandScape ? screenUtil.setSp(20) : screenUtil.setSp(40),
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
            label: (counter.toInt() - 1).toString(),
            value: counter,
            min: 1,
            max: 10,
            divisions: 10,
            onChanged: func,
          ),
        ),
      ],
    );
  }
}
