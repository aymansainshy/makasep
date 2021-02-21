import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/add_advertise_location_screen.dart';
import '../bloc/fetch_type/fetch_type_bloc.dart';
import '../providers/modifid_real_estate_provider.dart';
import '../utils/app_constant.dart';

class AddAdvertisePhontoScreen extends StatelessWidget {
  static const routeName = "/add-advertisePhoto-screen";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
          "2 اضافة اعلان",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Consumer<ModifiedRealEstat>(
          builder: (context, modifiedRealEstateProvider, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "نوع العقار",
                style: TextStyle(
                  fontSize:
                      isLandScape ? screenUtil.setSp(25) : screenUtil.setSp(50),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonHideUnderline(
                child: BlocBuilder<FetchTypeBloc, FetchTypeState>(
                  builder: (context, state) {
                    if (state is FetchTypeDone) {
                      return DropdownButton(
                        items: state.typeList
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(e.name),
                                value: e.id,
                              ),
                            )
                            .toList(),
                        value: int.parse(
                            modifiedRealEstateProvider.reatEstate.type),
                        onChanged: (value) {
                          modifiedRealEstateProvider.setType(value);
                        },
                      );
                    }
                    return Text("Done");
                  },
                ),
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(height: 10),
              Container(
                height: isLandScape
                    ? screenUtil.setHeight(600)
                    : screenUtil.setHeight(400),
                width: isLandScape
                    ? screenUtil.setWidth(250)
                    : screenUtil.setWidth(400),
                decoration: BoxDecoration(
                  color: AppColors.scondryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: modifiedRealEstateProvider.storedImage == null
                      ? Container(
                          color: AppColors.primaryColor,
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.add),
                              color: Colors.white,
                              onPressed: () {
                                modifiedRealEstateProvider.picImage();
                              },
                            ),
                          ),
                        )
                      : Image.file(
                          modifiedRealEstateProvider.storedImage,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: isLandScape
                    ? screenUtil.setHeight(230)
                    : screenUtil.setHeight(150),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.white,
                  textColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "اضافة صورة",
                        style: TextStyle(
                          fontSize: isLandScape
                              ? screenUtil.setSp(25)
                              : screenUtil.setSp(35),
                          letterSpacing: 1.5,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    modifiedRealEstateProvider.picImage();
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: isLandScape
                    ? screenUtil.setHeight(230)
                    : screenUtil.setHeight(150),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: AppColors.primaryColor,
                  textColor: Colors.white,
                  child: Text(
                    "استمرار",
                    style: TextStyle(
                      fontSize: isLandScape
                          ? screenUtil.setSp(25)
                          : screenUtil.setSp(40),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AddAdvertiseLocationScreen.routeName);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
