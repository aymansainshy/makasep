import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/advertisment_info.dart';
import '../widgets/discreption_text.dart';
import '../utils/app_constant.dart';

class RealEstateDetailScreen extends StatelessWidget {
  static const routeName = '/real-estate-detail-screen';

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    ScreenUtil screenUtil = ScreenUtil();
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColors.primaryColor,
      //   title: Text("Real Estates Detail"),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250,
            backgroundColor: AppColors.primaryColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "Real Estate Detail Screen",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            collapsedHeight: 65,
            pinned: true,
            elevation: 0.0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: isLandScape
                        ? screenUtil.setSp(40)
                        : screenUtil.setSp(60),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: isLandScape
                          ? screenUtil.setSp(50)
                          : screenUtil.setSp(60),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(),
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              background: Image.asset(
                "assets/images/sudan.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(
                    "Real Estate for sale",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isLandScape
                          ? screenUtil.setSp(30)
                          : screenUtil.setSp(45),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '5,000,000',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isLandScape
                                ? screenUtil.setSp(30)
                                : screenUtil.setSp(45),
                            color: AppColors.scondryColor,
                          ),
                        ),
                        TextSpan(
                          text: 'SDG',
                          style: TextStyle(
                            // fontFamily: "Cairo",
                            color: Colors.red,
                            fontSize: isLandScape
                                ? screenUtil.setSp(20)
                                : screenUtil.setSp(30),
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Text(
                    "Khartoum,Alriyad , Al mashtal Street",
                    style: TextStyle(
                      // fontFamily: "Cairo",
                      color: Colors.grey.shade700,
                      fontSize: isLandScape
                          ? screenUtil.setSp(20)
                          : screenUtil.setSp(40),
                      letterSpacing: 1,
                    ),
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "Type",
                  widget: Text(
                    "Mafrosha",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: isLandScape
                          ? screenUtil.setSp(20)
                          : screenUtil.setSp(40),
                      letterSpacing: 1,
                    ),
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "Rooms",
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.room_outlined),
                      Text(
                        "3",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: isLandScape
                              ? screenUtil.setSp(20)
                              : screenUtil.setSp(40),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "Halls",
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.highlight_alt_outlined),
                      Text(
                        "3",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: isLandScape
                              ? screenUtil.setSp(20)
                              : screenUtil.setSp(40),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "Bathrooms",
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.settings_brightness_sharp),
                      Text(
                        "3",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: isLandScape
                              ? screenUtil.setSp(20)
                              : screenUtil.setSp(40),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "Steps",
                  widget: Text(
                    "Under grown",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: isLandScape
                          ? screenUtil.setSp(20)
                          : screenUtil.setSp(40),
                      letterSpacing: 1,
                    ),
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "Real Estate Old",
                  widget: Text(
                    "7 years",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: isLandScape
                          ? screenUtil.setSp(20)
                          : screenUtil.setSp(40),
                      letterSpacing: 1,
                    ),
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "Ketchen",
                  widget: Icon(Icons.ring_volume_sharp),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "Parking",
                  widget: Icon(Icons.ring_volume_sharp),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "Asanser",
                  widget: Icon(Icons.ring_volume_sharp),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "Air Condition",
                  widget: Icon(Icons.ring_volume_sharp),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "Ketchen",
                  widget: Icon(Icons.ring_volume_sharp),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "Views",
                  widget: Text(
                    "45",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: isLandScape
                          ? screenUtil.setSp(20)
                          : screenUtil.setSp(40),
                      letterSpacing: 1,
                    ),
                  ),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "Adertisment No",
                  widget: Text(
                    "45",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: isLandScape
                          ? screenUtil.setSp(20)
                          : screenUtil.setSp(40),
                      letterSpacing: 1,
                    ),
                  ),
                ),
                DescriptionText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                ),
                AdvertisInfo(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                ),
                LocationOnMap(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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

class BuildContainerRowText extends StatelessWidget {
  const BuildContainerRowText({
    Key key,
    @required this.isLandScape,
    @required this.screenUtil,
    @required this.widget,
    @required this.color,
    @required this.text,
  }) : super(key: key);

  final bool isLandScape;
  final ScreenUtil screenUtil;
  final String text;
  final Color color;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              color: color,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: isLandScape
                        ? screenUtil.setSp(20)
                        : screenUtil.setSp(40),
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Container(
              height: 40,
              color: color,
              child: Center(
                child: widget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
