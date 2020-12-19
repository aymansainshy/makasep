import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/real_estates_screen.dart';
import '../models/category_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key key,
    @required this.screenUtil,
    @required this.category,
  }) : super(key: key);

  final ScreenUtil screenUtil;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RealEstateScreen.routeName);
      },
      child: Container(
        height: screenUtil.setHeight(400),
        width: screenUtil.setWidth(400),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              spreadRadius: 0.1,
              offset: Offset(0.5, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Image.asset(
                  category.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                category.title,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                  fontSize: screenUtil.setSp(40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
