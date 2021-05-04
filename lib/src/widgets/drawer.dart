import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/build_and _contractor_screen.dart';
import '../screens/add_advertise_role_screen.dart';
import '../screens/especial_offers_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/today_ads_screen.dart';
import '../providers/auth_provider.dart';
import '../screens/best_ads_screen.dart';
import '../screens/chats_screen.dart';
import '../utils/app_constant.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Drawer(
      child: SafeArea(
              child: Scaffold(
          // backgroundColor: AppColors.primaryColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 25),

                  Container(),
                  // Spacer(),
                  // DropdownButtonHideUnderline(
                  //   child: DropdownButton(
                  //     // dropdownColor: AppColors.primaryColor,
                  //     items: langugeProvider.languages
                  //         .map(
                  //           (lang) => DropdownMenuItem(
                  //             value: lang.localName,
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceAround,
                  //               children: [
                  //                 Text(
                  //                   lang.localName,
                  //                   style: TextStyle(
                  //                     fontSize: isLandScape
                  //                         ? screenUtil.setSp(20)
                  //                         : screenUtil.setSp(35),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   height: 5,
                  //                 ),
                  //                 Container(
                  //                   height: isLandScape
                  //                       ? screenUtil.setHeight(55)
                  //                       : screenUtil.setHeight(40),
                  //                   width: isLandScape
                  //                       ? screenUtil.setWidth(55)
                  //                       : screenUtil.setWidth(40),
                  //                   child: Image.asset(
                  //                     lang.flag,
                  //                     fit: BoxFit.contain,
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //             onTap: () {
                  //               // langugeProvider
                  //               //     .changeLanguage(Locale(lang.code));
                  //             },
                  //           ),
                  //         )
                  //         .toList(),
                  //     onChanged: (value) {
                  //       setState(() {
                  //         // appLang = value;
                  //       });
                  //     },
                  //     value: appLang,
                  //   ),
                  // ),

                  CircleAvatar(
                    radius: 55,
                    backgroundColor: AppColors.primaryColor,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        authProvider.imageUrl == null
                            ? CircleAvatar(
                                radius: 53,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  size: 100,
                                  color: AppColors.primaryColor,
                                ),
                              )
                            : Container(
                                height: screenUtil.setHeight(500),
                                width: screenUtil.setWidth(500),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(70),
                                  ),
                                  child: Image.network(
                                    authProvider.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        Positioned(
                          child: CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(
                                Icons.edit,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(EditProfileScreen.routeName);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "${authProvider.userName}",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      if (authProvider.isAuth)
                        Expanded(
                          child: BuilDraweGridViewItem(
                            imageUrl: "assets/icons/file-contract.png",
                            text: "اضافة إعلان",
                            function: () {
                              Navigator.of(context)
                                  .pushNamed(AddAdvertiseRoleScreen.routeName);
                            },
                          ),
                        ),
                      Expanded(
                        child: BuilDraweGridViewItem(
                          imageUrl: "assets/icons/home.png",
                          text: "الرئيسية",
                          function: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BuilDraweGridViewItem(
                          imageUrl: "assets/icons/buildeing.png",
                          text: "البناء والمقاولات",
                          function: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BuildAndContractors(
                                  userId: authProvider.userId,
                                ),
                              ),
                            );
                            // Navigator.of(context)
                            //     .pushNamed(BuildAndContractors.routeName);
                          },
                        ),
                      ),
                      Expanded(
                        child: BuilDraweGridViewItem(
                          imageUrl: "assets/icons/bestadbertise2.png",
                          text: "عروض مميزة",
                          function: () {
                            Navigator.of(context)
                                .pushNamed(EspecialOffersScreen.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BuilDraweGridViewItem(
                          imageUrl: "assets/icons/newspaper.png",
                          text: "اعلانات اليوم",
                          function: () {
                            Navigator.of(context)
                                .pushNamed(TodayAdsScreen.routeName);
                          },
                        ),
                      ),
                      Expanded(
                        child: BuilDraweGridViewItem(
                          imageUrl: "assets/icons/bell.png",
                          text: "المحادثات",
                          function: () {
                            Navigator.of(context)
                                .pushNamed(ChatsScreen.routeName);
                            // Navigator.of(context)
                            //     .pushNamed(OrderScreen.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (authProvider.isAuth)
                        Expanded(
                          child: BuilDraweGridViewItem(
                            imageUrl: "assets/icons/logout.png",
                            text: "تسجيل خروج",
                            function: () async {
                              Navigator.of(context).pop();
                              await authProvider.logOut();
                              Navigator.pushReplacementNamed(
                                context,
                                '/',
                              );
                            },
                          ),
                        ),
                      if (!authProvider.isAuth)
                        Expanded(
                          child: BuilDraweGridViewItem(
                            imageUrl: "assets/icons/logout.png",
                            text: "تسجيل دخول",
                            function: () async {
                              Navigator.of(context).pop();

                              Navigator.pushReplacementNamed(
                                context,
                                '/',
                              );
                            },
                          ),
                        ),
                      Expanded(
                        child: BuilDraweGridViewItem(
                          imageUrl: "assets/icons/Star.png",
                          text: "المفضلة",
                          function: () {
                            Navigator.of(context)
                                .pushNamed(BestAdsScreen.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BuilDraweGridViewItem extends StatelessWidget {
  const BuilDraweGridViewItem({
    this.imageUrl,
    this.function,
    this.text,
    Key key,
  }) : super(key: key);

  final String imageUrl;
  final Function function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 100,
        // width: 180,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        padding: EdgeInsets.only(top: 5, left: 5, right: 3),
        margin: EdgeInsets.only(top: 5, left: 5, right: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 5),
                child: Image.asset(
                  imageUrl,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
