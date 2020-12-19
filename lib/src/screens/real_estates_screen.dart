import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_constant.dart';

class RealEstateScreen extends StatefulWidget {
  static const routeName = "/real-estate-screen";

  @override
  _RealEstateScreenState createState() => _RealEstateScreenState();
}

class _RealEstateScreenState extends State<RealEstateScreen> {
  List<Widget> _pages;
  @override
  void initState() {
    _pages = [
      Newest(),
      Price(),
      Area(),
    ];
    super.initState();
  }

  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Real Estates"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 4),
                  _buildTapSelector(
                    mediaQuery / 4,
                    "Newest",
                    0,
                  ),
                  SizedBox(height: 4),
                  _buildTapSelector(
                    mediaQuery / 4,
                    "Price",
                    1,
                  ),
                  SizedBox(height: 4),
                  _buildTapSelector(
                    mediaQuery / 4,
                    "Area",
                    2,
                  ),
                ],
              ),
            ),
          ),
          _pages[_selectedItemIndex],
        ],
      ),
    );
  }

  Widget _buildTapSelector(
    Size mediaQuery,
    String text,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        height: 40,
        width: mediaQuery.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: index == _selectedItemIndex
            ? Container(
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.all(4),
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.all(4),
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class Area extends StatelessWidget {
  const Area({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 4,
            right: 4,
          ),
          child: Center(
            child: Text("Area"),
          ),
        ),
        childCount: 50,
      ),
    );
  }
}

class Price extends StatelessWidget {
  const Price({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 4,
            right: 4,
          ),
          child: Center(
            child: Text("Price"),
          ),
        ),
        childCount: 50,
      ),
    );
  }
}

class Newest extends StatelessWidget {
  const Newest({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 4,
            right: 4,
          ),
          child: Center(
            child: Text("Newest"),
          ),
        ),
        childCount: 50,
      ),
    );
  }
}
