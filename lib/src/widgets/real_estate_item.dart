import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makasep/src/models/real_estate_model.dart';

import '../screens/real_estate_detail_screen.dart';
import '../utils/app_constant.dart';

class RealEstateItem extends StatefulWidget {
  final ScreenUtil screenUtil;
  final RealEstate realEstat;
  final bool isLandScape;

  const RealEstateItem({
    Key key,
    this.screenUtil,
    this.isLandScape,
    this.realEstat,
  }) : super(key: key);

  @override
  _MealItemState createState() => _MealItemState();
}

class _MealItemState extends State<RealEstateItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RealEstateDetailScreen(
              realEstat: widget.realEstat,
            ),
          ),
        );
      },
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
                                '${realEstateType(int.parse(widget.realEstat.type))} ${realEstatePrimaryType(widget.realEstat.categoryType)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: widget.isLandScape
                                      ? widget.screenUtil.setSp(20)
                                      : widget.screenUtil.setSp(40),
                                  wordSpacing: 1.0,
                                ),
                              ),
                            ),
                            Spacer(),
                            // Icon(
                            //   Icons.star,
                            //   size: widget.isLandScape
                            //       ? widget.screenUtil.setSp(35)
                            //       : widget.screenUtil.setSp(45),
                            //   color: Colors.orange,
                            // ),
                            // SizedBox(
                            //   width: widget.screenUtil.setWidth(25),
                            // ),
                            // Material(
                            //   borderRadius: BorderRadius.circular(40.0),
                            //   elevation: 5.0,
                            //   child: InkWell(
                            //     onTap: () {},
                            //     child: CircleAvatar(
                            //       backgroundColor: Colors.white,
                            //       radius: widget.isLandScape
                            //           ? widget.screenUtil.setSp(25)
                            //           : widget.screenUtil.setSp(40),
                            //       child: Icon(
                            //         Icons.bookmark,
                            //         color: Colors.redAccent,
                            //         size: widget.isLandScape
                            //             ? widget.screenUtil.setSp(35)
                            //             : widget.screenUtil.setSp(50),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Transform.translate(
                          offset: Offset(0, -2),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${widget.realEstat.price.toString()}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: widget.isLandScape
                                        ? widget.screenUtil.setSp(25)
                                        : widget.screenUtil.setSp(40),
                                    color: AppColors.scondryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: 'جنيه',
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
                            "${widget.realEstat.details.rooms} غرف - ${widget.realEstat.details.hall} صالة - ${widget.realEstat.details.bathroom} حمام",

                            // "4 غرف , 1 صالة , 2 حمام",
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: widget.isLandScape
                                  ? widget.screenUtil.setSp(20)
                                  : widget.screenUtil.setSp(35),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, -5),
                          child: FittedBox(
                            child: Text(
                              "${widget.realEstat.description}....",
                              // "الخرطوم الرياض , شارع المشتل ",
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: widget.isLandScape
                                    ? widget.screenUtil.setSp(20)
                                    : widget.screenUtil.setSp(35),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: widget.isLandScape ? 250 : 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                    child: Container(
                      color: Colors.white,
                      child: FadeInImage(
                        placeholder: AssetImage(
                          "assets/images/building.png",
                        ),
                        image: NetworkImage(
                            "http://162.0.230.58${widget.realEstat.imageUrl}"),
                        fit: BoxFit.fill,
                      ),
                      height: widget.isLandScape
                          ? widget.screenUtil.setHeight(720)
                          : widget.screenUtil.setHeight(330),
                      width: widget.screenUtil.setWidth(400),
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
