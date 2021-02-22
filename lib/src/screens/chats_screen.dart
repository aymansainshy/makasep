import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../screens/masseges_screen.dart';
import '../providers/massages_provider.dart';
import '../providers/auth_provider.dart';
import '../utils/app_constant.dart';

import 'package:getwidget/getwidget.dart';

class ChatsScreen extends StatelessWidget {
  static const routeName = "/chats-screen";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    // ScreenUtil screenUtil = ScreenUtil();
    // var isLandScape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;

    final _userData = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: Provider.of<MassagesProvider>(context, listen: false)
            .fetchUserChat(_userData.userId),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: sleekCircularSlider(
                context,
                40,
                AppColors.primaryColor,
                AppColors.scondryColor,
              ),
            );
          } else {
            if (snapShot.error != null) {
              return Text("يوجد خطأ الرجاء المحاولة لاحقا");
            } else {
              return Consumer<MassagesProvider>(
                builder: (context, massages, child) => ListView.builder(
                  itemCount: massages.userChat.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3.0,
                      child: GFListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return MassagesScreen(
                                chatId:
                                    massages.userChat[index].chatId.toString(),
                              );
                            },
                          ));
                        },
                        avatar: GFAvatar(
                          backgroundImage: NetworkImage(
                            massages.userChat[index].realEstateImageUrl,
                          ),
                        ),
                        titleText:
                            massages.userChat[index].realEstateId.toString(),
                        subtitleText:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing',
                        icon: Icon(
                          Icons.message,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
