import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/fetch_favorite_realEstate/fetch_favorites_realestate_bloc.dart';
import '../providers/auth_provider.dart';
import '../widgets/real_estate_item.dart';
import '../utils/app_constant.dart';

class BestAdsScreen extends StatelessWidget {
  static const routeName = "/BestAds-screen";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _loadedDate(String userId, BuildContext context) async {
    BlocProvider.of<FetchFavoritesRealestateBloc>(context, listen: false).add(
      FetchFavoritesRealEstate(
        userId: userId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final userData = Provider.of<AuthProvider>(context, listen: false);
    _loadedDate(userData.userId, context);
    return Scaffold(
      key: _scaffoldKey,
      // drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "افضل الاعلانات ",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: BlocBuilder<FetchFavoritesRealestateBloc,
          FetchFavoritesRealestateState>(
        builder: (context, state) {
          if (state is FetchFavoritesInProgress) {
            return Center(
              child: sleekCircularSlider(
                  context, 40, AppColors.primaryColor, AppColors.scondryColor),
            );
          } else if (state is FetchFavoritesInError) {
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
                    state.errorMassege,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            );
          } else if (state is FetchFavoritesInDone) {
            if (state.realEstates.isEmpty) {
              return Center(
                child: Text(
                  "عفوا لا يوجد لديك بيانات مفضلة",
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
                  realEstat: state.realEstates[index],
                  screenUtil: screenUtil,
                  isLandScape: isLandScape,
                ),
              ),
              itemCount: state.realEstates.length,
            );
          } else {
            return Center(child: Text("Done"));
          }
        },
      ),
    );
  }
}
