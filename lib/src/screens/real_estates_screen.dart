import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/real_estate_item.dart';
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "العقارات",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            elevation: 0.0,
            collapsedHeight: 115,
            backgroundColor: Colors.white,
            flexibleSpace: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTapSelector(
                        mediaQuery / 4,
                        "الاحدث",
                        0,
                      ),
                      _buildTapSelector(
                        mediaQuery / 4,
                        "السعر",
                        1,
                      ),
                      _buildTapSelector(
                        mediaQuery / 4,
                        "المساحة",
                        2,
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        // DropdownButtonHideUnderline(
                        //   child: DropdownButton(
                        //     items: [
                        //       DropdownMenuItem(child: Text("Khartoum")),
                        //       DropdownMenuItem(child: Text("Bahry")),
                        //       DropdownMenuItem(child: Text("Omdurman")),
                        //       DropdownMenuItem(child: Text("Alhaj Yousef")),
                        //     ],
                        //     onChanged: (value) {},
                        //   ),
                        // ),
                        SizedBox(width: 5),
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            items: [
                              DropdownMenuItem(child: Text("عمارة")),
                              DropdownMenuItem(child: Text("شقق")),
                              DropdownMenuItem(child: Text("منزل")),
                            ],
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  )
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
                      fontSize: 12,
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
                      fontSize: 12,
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
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 4,
            right: 4,
          ),
          child: RealEstateItem(
            screenUtil: screenUtil,
            isLandScape: isLandScape,
          ),
        ),
        childCount: 25,
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
            child: Text("السعر"),
          ),
        ),
        childCount: 30,
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
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 4,
            right: 4,
          ),
          child: RealEstateItem(
            screenUtil: screenUtil,
            isLandScape: isLandScape,
          ),
        ),
        childCount: 25,
      ),
    );
  }
}
