import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'real_estate_item.dart';
import '../utils/app_constant.dart';
import '../bloc/real_estats_bloc/real_estats_bloc_bloc.dart';

class BestAds extends StatelessWidget {
  _loadedDate(BuildContext context) async {
    BlocProvider.of<RealEstatsBlocBloc>(context, listen: false).add(
      FetchTodayRealEstate(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _loadedDate(context);
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 4,
        right: 4,
      ),
      child: BlocBuilder<RealEstatsBlocBloc, RealEstatsBlocState>(
        builder: (context, state) {
          if (state is RealEstatsLoading) {
            return Center(
              child: sleekCircularSlider(
                  context, 40, AppColors.primaryColor, AppColors.scondryColor),
            );
          } else if (state is RealEstatsError) {
            return Center(
              child: Text("An error occurred"),
            );
          } else if (state is RealEstatsLoaded) {
            if (state.realEstats.isEmpty) {
              return Center(
                child: Text("عفوا لايوجد اعلانات مفضلة لهذا اليوم"),
              );
            }
            return ListView.builder(
              itemCount: state.realEstats.length,
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
    );
  }
}
