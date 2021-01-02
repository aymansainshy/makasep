import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_constant.dart';
import '../lang/language_provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final langugeProvider = Provider.of<LanguageProvider>(context);
    String appLang =
        langugeProvider.appLocal.toString() == "ar" ? "العربية" : "English";

    return Drawer(
      child: Scaffold(
        // backgroundColor: AppColors.primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25),
                Row(
                  children: [
                    Container(),
                    Spacer(),
                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        // dropdownColor: AppColors.primaryColor,
                        items: langugeProvider.languages
                            .map(
                              (lang) => DropdownMenuItem(
                                value: lang.localName,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      lang.localName,
                                      style: TextStyle(
                                        fontSize: isLandScape
                                            ? screenUtil.setSp(20)
                                            : screenUtil.setSp(35),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: isLandScape
                                          ? screenUtil.setHeight(55)
                                          : screenUtil.setHeight(40),
                                      width: isLandScape
                                          ? screenUtil.setWidth(55)
                                          : screenUtil.setWidth(40),
                                      child: Image.asset(
                                        lang.flag,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  langugeProvider
                                      .changeLanguage(Locale(lang.code));
                                },
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            appLang = value;
                          });
                        },
                        value: appLang,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 55,
                  backgroundColor: AppColors.primaryColor,
                  child: CircleAvatar(
                    radius: 53,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                Text(
                  "Ayman Sainshy",
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
                    Expanded(
                      child: BuilDraweGridViewItem(
                        imageUrl: "assets/icons/file-contract.png",
                      ),
                    ),
                    Expanded(
                      child: BuilDraweGridViewItem(
                        imageUrl: "assets/icons/bestadbertise2.png",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: BuilDraweGridViewItem(
                        imageUrl: "assets/icons/buildeing.png",
                      ),
                    ),
                    Expanded(
                      child: BuilDraweGridViewItem(
                        imageUrl: "assets/icons/newspaper.png",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: BuilDraweGridViewItem(
                        imageUrl: "assets/icons/bell.png",
                      ),
                    ),
                    Expanded(
                      child: BuilDraweGridViewItem(
                        imageUrl: "assets/icons/Star.png",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: BuilDraweGridViewItem(
                        imageUrl: "assets/icons/money-bill-wave-alt.png",
                      ),
                    ),
                    Expanded(
                      child: BuilDraweGridViewItem(
                        imageUrl: "assets/icons/other.png",
                      ),
                    ),
                  ],
                )
              ],
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
    Key key,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Add Advrtisment",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
