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
          child: Column(
            children: [
              Container(
                height: 260,
                padding: const EdgeInsets.only(top: 20),
                color: AppColors.primaryColor,
                child: Column(
                  children: [
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
                    SizedBox(height: 10),
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                    ),
                    Text(
                      "Ayman Sainshy",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  children: [
                    BuilDraweGridViewItem(),
                    BuilDraweGridViewItem(),
                    BuilDraweGridViewItem(),
                    BuilDraweGridViewItem(),
                    BuilDraweGridViewItem(),
                    BuilDraweGridViewItem(),
                    BuilDraweGridViewItem(),
                    BuilDraweGridViewItem(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuilDraweGridViewItem extends StatelessWidget {
  const BuilDraweGridViewItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
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
