import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/real_estats_bloc/real_estats_bloc_bloc.dart';
import '../utils/app_constant.dart';
import '../widgets/real_estate_item.dart';
// import '../widgets/drawer.dart';

class EspecialOffersScreen extends StatelessWidget {
  static const routeName = "/especial-offers-screen";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _loadedDate(BuildContext context) async {
    BlocProvider.of<RealEstatsBlocBloc>(context, listen: false).add(
      FetchSpecialRealEstate(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _loadedDate(context);
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      key: _scaffoldKey,
      // drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "عروض مميزة",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 4,
          right: 4,
        ),
        child: BlocBuilder<RealEstatsBlocBloc, RealEstatsBlocState>(
          builder: (context, state) {
            if (state is RealEstatsLoading) {
              return Center(
                child: sleekCircularSlider(context, 40, AppColors.primaryColor,
                    AppColors.scondryColor),
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
                itemCount: 3,
                itemBuilder: (context, index) => RealEstateItem(
                  realEstat: state.realEstats[index],
                  screenUtil: screenUtil,
                  isLandScape: isLandScape,
                ),
              );
            }
            return Text("Done");
          },
        ),
      ),
    );
  }
}
