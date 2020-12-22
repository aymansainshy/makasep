import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makasep/src/utils/app_constant.dart';

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
                Container(
                  height: 200,
                  color: Colors.red,
                ),
                Container(
                  height: 200,
                  color: Colors.blue,
                ),
                Container(
                  height: 200,
                  color: Colors.yellow,
                ),
                Container(
                  height: 200,
                  color: Colors.green,
                ),
                Container(
                  height: 200,
                  color: Colors.red[900],
                ),
                Container(
                  height: 200,
                  color: Colors.green,
                ),
                Container(
                  height: 200,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
