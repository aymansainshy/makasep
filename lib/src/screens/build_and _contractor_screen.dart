import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_constant.dart';
import '../widgets/build_form_field.dart';
// import '../widgets/drawer.dart';

class BuildAndContractors extends StatefulWidget {
  static const routeName = "/build-and-contractor-screen";

  @override
  _BuildAndContractorsState createState() => _BuildAndContractorsState();
}

class _BuildAndContractorsState extends State<BuildAndContractors> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  int _selectedItemIndex;

  var inputDate = {
    'phoneNumber': '',
    'city': '',
    'description': '',
  };

  void _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    print(inputDate['email']);
    print(inputDate['password']);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      // drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "البناء والمقاولات",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTapSelector(
                    mediaQuery / 2.2,
                    "المخططات الهندسية",
                    0,
                  ),
                  _buildTapSelector(
                    mediaQuery / 2.2,
                    "البناء",
                    1,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTapSelector(
                    mediaQuery / 2.2,
                    "استشارات الشراء",
                    2,
                  ),
                  _buildTapSelector(
                    mediaQuery / 2.2,
                    "الاشراف",
                    3,
                  ),
                ],
              ),
              _buildTapSelector(
                mediaQuery,
                "التصميم الداخلى",
                4,
              ),
              SizedBox(height: 5),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "رقم الجوال",
                        style: TextStyle(fontSize: 15),
                      ),
                      BuilFormField(
                        textInputAction: TextInputAction.next,
                        contentPadding: 8.0,
                        keyboardType: TextInputType.text,
                        // fieldName: "المساحة",
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "الرجاء ادخال رقم الجوال  ";
                          }
                        },
                        onSaved: (value) {
                          inputDate["area"] = value;
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        " المدينة",
                        style: TextStyle(fontSize: 15),
                      ),
                      BuilFormField(
                        textInputAction: TextInputAction.next,
                        contentPadding: 8.0,
                        keyboardType: TextInputType.number,
                        // fieldName: "السعر الاجمالى",
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "الرجاء ادخال اسم المدينة";
                          }
                        },
                        onSaved: (value) {
                          inputDate["price"] = value;
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        "الوصف",
                        style: TextStyle(fontSize: 15),
                      ),
                      BuilFormField(
                        textInputAction: TextInputAction.next,
                        contentPadding: 8.0,
                        keyboardType: TextInputType.multiline,
                        // fieldName: "وصف العقار",
                        hintText: "قم بكتابة الوصف هنا  ",
                        hintStyle: TextStyle(
                          fontSize: 13,
                          wordSpacing: 2.2,
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "الرجاء قم بكتابة الوصف";
                          }
                        },
                        onSaved: (value) {
                          inputDate["description"] = value;
                        },
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
                            "ارسال",
                            style: TextStyle(
                              fontSize: isLandScape
                                  ? screenUtil.setSp(25)
                                  : screenUtil.setSp(45),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            _saveForm();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTapSelector(
    Size mediaQuery,
    String text,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        height: 40,
        width: mediaQuery.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: index == _selectedItemIndex
            ? Container(
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.all(4),
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.all(4),
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
