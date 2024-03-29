import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makasep/src/providers/categories_provider.dart';
import 'package:provider/provider.dart';

import '../bloc/real_estats_bloc/real_estats_bloc_bloc.dart';
import '../widgets/real_estate_item.dart';
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
  var isInit = true;

  String catId;
  int filterStateId = 1;
  int _selectedItemIndex = 0;

  @override
  void didChangeDependencies() {
    if (isInit) {
      final routArg =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      catId = routArg['catId'];
      _loadedDate();
      _pages = [
        Newest(),
        Price(),
        Area(),
      ];
    }
    isInit = false;
    super.didChangeDependencies();
  }

  _loadedDate() async {
    BlocProvider.of<RealEstatsBlocBloc>(context, listen: false).add(
      GetRealEstate(
        catId: catId,
        filterId: filterStateId.toString(),
        selectedUrl: _selectedItemIndex,
      ),
    );
  }

  selectedFilter(int val) {
    setState(() {
      filterStateId = val;
    });
    _loadedDate();
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
      body: Column(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
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
                        child: Container(),

                        //  IconButton(
                        //   icon: Icon(Icons.search),
                        //   onPressed: () {},
                        // ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      DropdownButtonHideUnderline(
                        child: Consumer<CategoriesProvider>(
                          builder: (context, catType, child) {
                            return DropdownButton(
                              items: catType.secondryType
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: Text(e.name),
                                      value: e.id,
                                    ),
                                  )
                                  .toList(),
                              value: filterStateId,
                              onChanged: selectedFilter,
                            );
                          },
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

  Widget _buildTapSelector(Size mediaQuery, String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
        _loadedDate();
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
    return BlocBuilder<RealEstatsBlocBloc, RealEstatsBlocState>(
      builder: (context, state) {
        if (state is RealEstatsLoading) {
          return Center(
            child: sleekCircularSlider(
                context, 40, AppColors.primaryColor, AppColors.scondryColor),
          );
        } else if (state is RealEstatsError) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(5),
              height: screenUtil.setHeight(300),
              width: screenUtil.setWidth(700),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueGrey,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  state.errorMassage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        } else if (state is RealEstatsLoaded) {
          if (state.realEstats.isEmpty) {
            return Center(
              child: Text(
                "عفوا لا يوجد بيانات لهذا النوع",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 12,
                ),
              ),
            );
          }

          return ListView.builder(
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 4,
                right: 4,
              ),
              child: RealEstateItem(
                realEstat: state.realEstats[index],
                screenUtil: screenUtil,
                isLandScape: isLandScape,
              ),
            ),
            itemCount: state.realEstats.length,
          );
        } else {
          return Center(child: Text("Done"));
        }
      },
    );
  }
}

class Price extends StatelessWidget {
  const Price({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return BlocBuilder<RealEstatsBlocBloc, RealEstatsBlocState>(
      builder: (context, state) {
        if (state is RealEstatsLoading) {
          return Center(
            child: sleekCircularSlider(
                context, 40, AppColors.primaryColor, AppColors.scondryColor),
          );
        } else if (state is RealEstatsError) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(5),
              height: screenUtil.setHeight(300),
              width: screenUtil.setWidth(700),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueGrey,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  state.errorMassage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        } else if (state is RealEstatsLoaded) {
          if (state.realEstats.isEmpty) {
            return Center(
              child: Text(
                "عفوا لا يوجد بيانات لهذا النوع",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 12,
                ),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 4,
                right: 4,
              ),
              child: RealEstateItem(
                realEstat: state.realEstats[index],
                screenUtil: screenUtil,
                isLandScape: isLandScape,
              ),
            ),
            itemCount: state.realEstats.length,
          );
        } else {
          return Center(child: Text("Done"));
        }
      },
    );
  }
}

class Newest extends StatefulWidget {
  const Newest({
    Key key,
  }) : super(key: key);

  @override
  _NewestState createState() => _NewestState();
}

class _NewestState extends State<Newest> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return BlocBuilder<RealEstatsBlocBloc, RealEstatsBlocState>(
      builder: (context, state) {
        if (state is RealEstatsLoading) {
          return Center(
            child: sleekCircularSlider(
                context, 40, AppColors.primaryColor, AppColors.scondryColor),
          );
        } else if (state is RealEstatsError) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(5),
              height: screenUtil.setHeight(300),
              width: screenUtil.setWidth(700),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueGrey,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  state.errorMassage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        } else if (state is RealEstatsLoaded) {
          if (state.realEstats.isEmpty) {
            return Center(
              child: Text(
                "عفوا لا يوجد بيانات لهذا النوع",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 12,
                ),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 4,
                right: 4,
              ),
              child: RealEstateItem(
                realEstat: state.realEstats[index],
                screenUtil: screenUtil,
                isLandScape: isLandScape,
              ),
            ),
            itemCount: state.realEstats.length,
          );
        } else {
          return Center(child: Text("Done"));
        }
      },
    );
  }
}
