import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/real_estats_bloc/real_estats_bloc_bloc.dart';
import '../bloc/post_realEstate/post_realestate_bloc.dart';
import '../providers/modifid_real_estate_provider.dart';
import '../providers/categories_provider.dart';
import '../widgets/build_form_field.dart';
import '../providers/auth_provider.dart';
import '../screens/home_screen.dart';
import '../utils/app_constant.dart';

class AddAdvertiseDetaile2Screen extends StatefulWidget {
  static const routeName = "/add-advertise-detaile2-screen";

  @override
  _AddAdvertiseDetaile2ScreenState createState() =>
      _AddAdvertiseDetaile2ScreenState();
}

class _AddAdvertiseDetaile2ScreenState
    extends State<AddAdvertiseDetaile2Screen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var isCheck = false;
  ModifiedRealEstat _realEstate;
  AuthProvider _userData;
  var isInit = true;

  // var inputDate = {
  //   'area': '',
  //   'price': '',
  //   'description': '',
  // };

  @override
  void didChangeDependencies() {
    if (isInit) {
      _realEstate = Provider.of<ModifiedRealEstat>(context, listen: false);
      _userData = Provider.of<AuthProvider>(context, listen: false);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    if (!isCheck) {
      return;
    }
    _formKey.currentState.save();

    print(_realEstate.reatEstate.description + " EEEEEEEEEEEEEEEEEEEEEEEeeeee");

    BlocProvider.of<PostRealestateBloc>(context, listen: false).add(
      PostRealEstatee(
        image: _realEstate.storedImage,
        realEstats: _realEstate.reatEstate,
        userId: _userData.userId,
      ),
    );
  }

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
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          " ادخل تفاصيل الاعلان 5",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SingleChildScrollView(
              child: BlocConsumer<RealEstatsBlocBloc, RealEstatsBlocState>(
            listener: (context, state) {
              if (state is RealEstatsLoading) {
                showDialog(
                  context: context,
                  builder: (ctx) => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: Center(
                      child: sleekCircularSlider(
                        context,
                        40,
                        AppColors.primaryColor,
                        AppColors.scondryColor,
                      ),
                    ),
                  ),
                );
              }
              if (state is RealEstatsPosted) {
                Navigator.of(context).pop();
                _formKey.currentState.reset();
                _realEstate.reaSet();

                showDialog(
                  context: context,
                  builder: (ctx) => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: AlertDialog(
                      title: Text(
                        "طلبك تم بنجاح",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                        ),
                      ),
                      content: Text(
                        "تم اضافة الاعلان بنجاح",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushReplacementNamed(HomeScreen.routeName);
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (state is RealEstatsError) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("يوجد خطأ الرجاء المحاولة لاحقا"),
                    content: Text(state.errorMassage),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Ok"),
                      ),
                    ],
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "المساحة",
                    style: TextStyle(fontSize: 15),
                  ),
                  BuilFormField(
                    textInputAction: TextInputAction.next,
                    contentPadding: 8.0,
                    keyboardType: TextInputType.text,
                    // fieldName: "المساحة",
                    initialValue: _realEstate.reatEstate.area,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "الرجاء ادخال المساحة الفعلية للعقار";
                      }
                    },
                    onSaved: (value) {
                      _realEstate.setArea(value);
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    "السعر الاجمالى",
                    style: TextStyle(fontSize: 15),
                  ),
                  BuilFormField(
                    textInputAction: TextInputAction.next,
                    contentPadding: 8.0,
                    keyboardType: TextInputType.number,
                    // fieldName: "السعر الاجمالى",
                    initialValue: _realEstate.reatEstate.price.toString(),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "الرجاء ادخال السعر الفعلى للعقار";
                      }
                      if (double.tryParse(value).isNegative) {
                        return "الرجاء ادخال ارقام صحيحة";
                      }
                      if (double.parse(value) <= 0) {
                        return "سعر العقار لا يجب عن يقل عن 100 جنيه";
                      }
                    },
                    onSaved: (value) {
                      _realEstate.setPrice(double.parse(value));
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
                    hintText: "اكتب التفاصيل الاضافية هنا",
                    hintStyle: TextStyle(
                      fontSize: 13,
                      wordSpacing: 2,
                    ),
                    maxLines: 3,
                    initialValue: _realEstate.reatEstate.description,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "الرجاء كتابة وصف العقار";
                      }
                    },
                    onSaved: (value) {
                      _realEstate.setDescription(value);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.translate(
                          offset: Offset(10, 0),
                          child: Checkbox(
                            value: isCheck,
                            activeColor: AppColors.primaryColor,
                            onChanged: (value) {
                              setState(() {
                                isCheck = value;
                              });
                            },
                          ),
                        ),
                        Text(
                          "اوافق على شروط الاستخدام و ألتزم برسوم الاعلان",
                          style: TextStyle(
                            fontSize: screenUtil.setSp(32),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isCheck)
                    Text(
                      "الرجاء الموافقة بشروط الخدمة",
                      style: TextStyle(
                        color: Colors.red,
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
              );
            },
          )),
        ),
      ),
    );
  }
}
