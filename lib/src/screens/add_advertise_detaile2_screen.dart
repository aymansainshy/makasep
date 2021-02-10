import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makasep/src/widgets/build_form_field.dart';
import 'package:provider/provider.dart';

import '../providers/categories_provider.dart';
import '../providers/modifid_real_estate_provider.dart';
import '../models/real_estate_model.dart';
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
            child: Column(
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
            ),
          ),
        ),
      ),
    );
  }
}
