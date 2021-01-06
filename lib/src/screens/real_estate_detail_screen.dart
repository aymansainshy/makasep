import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/advertisment_info.dart';
import '../widgets/discreption_text.dart';
import '../widgets/location_on_map.dart';
import '../widgets/real_estate_item.dart';
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
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 15.0,
              spreadRadius: 0.5,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Container(
          color: Colors.white,
          child: Center(
            child: Icon(
              Icons.star,
              size: 30,
              color: Colors.orangeAccent,
            ),
          ),
        ),
      ),
      // appBar: AppBar(
      //   backgroundColor: AppColors.primaryColor,
      //   title: Text("Real Estates Detail"),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 230,
            backgroundColor: AppColors.primaryColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "تفاصيل العقار",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            collapsedHeight: 65,
            pinned: true,
            elevation: 0.0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0, top: 15.0),
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
                    "شقة للبيع",
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
                          text: 'جنيه',
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
                    "الخرطوم الرياض , شارع المشتل",
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
                  text: "النوع",
                  widget: Text(
                    "مفروشة",
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
                  text: "الغرف",
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
                  text: "الصالة",
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
                  text: "الحمام",
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
                  text: "الدور",
                  widget: Text(
                    "الطابق الارضي",
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
                  text: "عمر العقار",
                  widget: Text(
                    "7 سنوات",
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
                  text: "المطبخ",
                  widget: Icon(Icons.ring_volume_sharp),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "مدخل سيارة",
                  widget: Icon(Icons.ring_volume_sharp),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "مصعد",
                  widget: Icon(Icons.ring_volume_sharp),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "مكيفات",
                  widget: Icon(Icons.ring_volume_sharp),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade300,
                  text: "المطبخ",
                  widget: Icon(Icons.ring_volume_sharp),
                ),
                BuildContainerRowText(
                  isLandScape: isLandScape,
                  screenUtil: screenUtil,
                  color: Colors.grey.shade100,
                  text: "عدد المشاهدات",
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
                  text: "رقم العلان",
                  widget: Text(
                    "23",
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
                _reportContainer(),
                _semilerAds(isLandScape, screenUtil),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _semilerAds(bool isLandScape, ScreenUtil screenUtil) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "إعلانات مشابهة",
            style: TextStyle(
              color: Colors.grey.shade900,
              fontWeight: FontWeight.bold,
              fontSize:
                  isLandScape ? screenUtil.setSp(20) : screenUtil.setSp(45),
              letterSpacing: 1,
            ),
          ),
          Container(
            height: 350,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => RealEstateItem(
                screenUtil: screenUtil,
                isLandScape: isLandScape,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _reportContainer() {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      height: 50,
      // width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        border: Border.all(
          color: Colors.red,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "ابلاغ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          Expanded(
            child: Icon(
              Icons.ac_unit,
              color: Colors.red,
            ),
          ),
        ],
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
