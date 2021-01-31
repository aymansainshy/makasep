import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../widgets/real_estate_item.dart';
import '../providers/real_states_provider.dart';
import '../utils/app_constant.dart';

class RealEstateScreen extends StatefulWidget {
  static const routeName = "/real-estate-screen";

  const RealEstateScreen({
    Key key,
  }) : super(key: key);

  @override
  _RealEstateScreenState createState() => _RealEstateScreenState();
}

class _RealEstateScreenState extends State<RealEstateScreen> {
  List<Widget> _pages;

  // var catId;
  int filterStateId = 1;
  var isInite = true;

  @override
  void initState() {
    super.initState();
  }

  int _selectedItemIndex = 0;

  selectedFilter(int val) {
    setState(() {
      filterStateId = val;
    });
  }

  @override
  void didChangeDependencies() {
    if (isInite) {
      final routArg =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      final catId = routArg["catId"];
      _pages = [
        Newest(
          catId: catId,
          filter: filterStateId,
          fun: selectedFilter,
        ),
        Price(),
        Area(),
      ];
    }
    setState(() {
      isInite = false;
    });
    super.didChangeDependencies();
  }

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
      body:

          //  CustomScrollView(
          //     slivers: [
          //       SliverAppBar(
          //         automaticallyImplyLeading: false,
          //         pinned: true,
          //         elevation: 0.0,
          //         collapsedHeight: 115,
          //         backgroundColor: Colors.white,
          //         flexibleSpace: Padding(
          //           padding: const EdgeInsets.all(8.0),
          Column(
        children: [
          SafeArea(
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
                            DropdownMenuItem(
                              child: Text("عمارة"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("شقق"),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              child: Text("منزل"),
                              value: 3,
                            ),
                          ],
                          value: filterStateId,
                          onChanged: selectedFilter,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(child: _pages[_selectedItemIndex]),
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

class Newest extends StatefulWidget {
  final String catId;
  final int filter;
  final Function fun;
  const Newest({
    Key key,
    this.catId,
    this.fun,
    this.filter,
  }) : super(key: key);

  @override
  _NewestState createState() => _NewestState();
}

class _NewestState extends State<Newest> {
  @override
  Widget build(BuildContext context) {
    print(" ccccccccccccccccccccc" + widget.catId);
    print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee" +
        widget.filter.toString());

    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final realEstate = Provider.of<RealStatesProvider>(context, listen: false);
    return FutureBuilder(
      future: Provider.of<RealStatesProvider>(context, listen: false)
          .fetchRealStates(widget.catId, widget.filter.toString()),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              height: 20,
              child: sleekCircularSlider(context, screenUtil.setSp(100),
                  AppColors.primaryColor, AppColors.scondryColor),
            ),
          );
        } else if (snapShot.error != null) {
          return Center(
            child: Text(snapShot.error.toString()),
          );
        } else {
          return ListView.builder(
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 4,
                right: 4,
              ),
              child: ChangeNotifierProvider.value(
                value: realEstate.realStates[index],
                child: RealEstateItem(
                  screenUtil: screenUtil,
                  isLandScape: isLandScape,
                ),
              ),
            ),
            itemCount: realEstate.realStates.length,
          );
        }
      },
    );
  }
}
