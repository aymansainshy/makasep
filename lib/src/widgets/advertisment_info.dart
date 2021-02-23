import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../utils/app_constant.dart';
import '../bloc/semilar_real_estate/semilar_real_estate_bloc.dart';
import '../screens/masseges_screen.dart';
import '../providers/auth_provider.dart';

class AdvertisInfo extends StatelessWidget {
  final bool isLandScape;
  final ScreenUtil screenUtil;
  final String realEstateId;

  const AdvertisInfo({
    Key key,
    @required this.isLandScape,
    @required this.realEstateId,
    @required this.screenUtil,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _userData = Provider.of<AuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: BlocBuilder<SemilarRealEstateBloc, SemilarRealEstateState>(
        builder: (context, state) {
          if (state is SemilarRealEstateInProgress) {
            return Center(
              child: sleekCircularSlider(
                  context, 40, AppColors.primaryColor, AppColors.scondryColor),
            );
          }
          if (state is SemilarRealEstateError) {
            return Center(
              child: Text("يوجد خطأ الرجاء المحاولة لاحقا"),
            );
          }
          if (state is SemilarRealEstateLoadingDone) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "معلومات المعلن",
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: isLandScape
                        ? screenUtil.setSp(25)
                        : screenUtil.setSp(45),
                    letterSpacing: 1,
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Container(
                    // color: Colors.red,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "${state.userData.userName}",
                                  style: TextStyle(
                                    color: Colors.grey.shade900,
                                    fontSize: isLandScape
                                        ? screenUtil.setSp(25)
                                        : screenUtil.setSp(35),
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  "${state.userData.phoneNumber}",
                                  style: TextStyle(
                                    color: Colors.grey.shade900,
                                    fontSize: isLandScape
                                        ? screenUtil.setSp(25)
                                        : screenUtil.setSp(35),
                                    letterSpacing: 1,
                                  ),
                                ),
                                RaisedButton(
                                  color: AppColors.primaryColor,
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => MassagesScreen(
                                          realEstateId: realEstateId,
                                          realEstatOwner: state.userData.userId,
                                          userId: _userData.userId,
                                          isStarChat: true,
                                        ),
                                      ),
                                    );
                                    // Navigator.of(context)
                                    //     .pushNamed(MassagesScreen.routeName);
                                  },
                                  child: Text(
                                    "محادثة",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isLandScape
                                          ? screenUtil.setSp(25)
                                          : screenUtil.setSp(30),
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: screenUtil.setHeight(260),
                            child: state.userData.imageUrl == null
                                ? CircleAvatar(
                                    radius: 53,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.person,
                                      size: 100,
                                      color: AppColors.primaryColor,
                                    ),
                                  )
                                : Image.network(
                                    "${state.userData.imageUrl}",
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Text("Done"),
          );
        },
      ),
    );
  }
}
