import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../screens/add_advertise_photo_screen.dart';
import '../providers/modifid_real_estate_provider.dart';
import '../providers/categories_provider.dart';
import '../utils/app_constant.dart';

class AddAdvertiseScreen extends StatelessWidget {
  static const routeName = "/add-advertise-screen";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      // drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          " اضافة اعلان",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: categoriesProvider.categoryPostList.length,
          itemBuilder: (contex, i) => Column(
            children: [
              AddAdvertisContent(
                leading: categoriesProvider.categoryPostList[i].imageUrl,
                title: categoriesProvider.categoryPostList[i].title,
                onTap: () {
                  Provider.of<ModifiedRealEstat>(context, listen: false)
                      .setCatType(categoriesProvider.categoryPostList[i].id);
                  Navigator.of(context)
                      .pushNamed(AddAdvertisePhontoScreen.routeName);
                },
              ),
              SizedBox(
                height: screenUtil.setHeight(10),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  height: 6,
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddAdvertisContent extends StatelessWidget {
  final String leading;
  final String title;
  final Function onTap;

  const AddAdvertisContent({
    Key key,
    @required this.leading,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        leading: Container(
          margin: EdgeInsets.all(10),
          child: Image.asset(
            leading,
            fit: BoxFit.fill,
          ),
        ),
        trailing: Icon(
          Icons.navigate_next,
          size: 30,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
