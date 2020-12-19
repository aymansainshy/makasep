import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_constant.dart';

class RealEstateItem extends StatefulWidget {
  final ScreenUtil screenUtil;
  final bool isLandScape;

  const RealEstateItem({
    Key key,
    this.screenUtil,
    this.isLandScape,
  }) : super(key: key);

  @override
  _MealItemState createState() => _MealItemState();
}

class _MealItemState extends State<RealEstateItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: widget.isLandScape ? 150 : 130,
        child: Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Hero(
                        tag: 'realEstateID',
                        child: FadeInImage(
                          placeholder: AssetImage(
                            "assets/images/breakfast.png",
                          ),
                          image: AssetImage("assets/images/sudan.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      height: widget.isLandScape
                          ? widget.screenUtil.setHeight(660)
                          : widget.screenUtil.setHeight(330),
                      width: widget.screenUtil.setWidth(400),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 5.0,
                      right: 5.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Text(
                                'RealEstate Title',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: widget.isLandScape
                                      ? widget.screenUtil.setSp(30)
                                      : widget.screenUtil.setSp(43),
                                  wordSpacing: 1.0,
                                ),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.star,
                              size: widget.isLandScape
                                  ? widget.screenUtil.setSp(35)
                                  : widget.screenUtil.setSp(45),
                              color: Colors.orange,
                            ),
                            SizedBox(
                              width: widget.screenUtil.setWidth(25),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(40.0),
                              elevation: 5.0,
                              child: InkWell(
                                onTap: () {},
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: widget.isLandScape
                                      ? widget.screenUtil.setSp(25)
                                      : widget.screenUtil.setSp(40),
                                  child: Icon(
                                    Icons.bookmark,
                                    color: Colors.redAccent,
                                    size: widget.isLandScape
                                        ? widget.screenUtil.setSp(35)
                                        : widget.screenUtil.setSp(50),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Transform.translate(
                          offset: Offset(0, -5),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '5,000,000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: widget.isLandScape
                                        ? widget.screenUtil.setSp(30)
                                        : widget.screenUtil.setSp(40),
                                    color: AppColors.scondryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: 'SDG',
                                  style: TextStyle(
                                    // fontFamily: "Cairo",
                                    color: Colors.red,
                                    fontSize: widget.isLandScape
                                        ? widget.screenUtil.setSp(20)
                                        : widget.screenUtil.setSp(30),
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.isLandScape
                              ? widget.screenUtil.setHeight(40)
                              : widget.screenUtil.setHeight(45),
                        ),
                        Transform.translate(
                          offset: Offset(0, -5),
                          child: Text(
                            "4 Rooms, 1 Hall, 2 Bathroom",
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: widget.isLandScape
                                  ? widget.screenUtil.setSp(25)
                                  : widget.screenUtil.setSp(35),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, -5),
                          child: Text(
                            "Khartoum Al righat , Al mashtal Street ",
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: widget.isLandScape
                                  ? widget.screenUtil.setSp(25)
                                  : widget.screenUtil.setSp(35),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
