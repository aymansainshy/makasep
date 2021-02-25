import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/massages_provider.dart';
import '../widgets/build_form_field.dart';
import '../providers/auth_provider.dart';
import '../utils/app_constant.dart';

class ReportScreen extends StatefulWidget {
  final int realEstateId;

  const ReportScreen({Key key, this.realEstateId}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();

  AuthProvider _userData;
  String _reportContent = "";
  var isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (isInit) {
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
    _formKey.currentState.save();

    print("user id ....." + _userData.userId.toString());
    print("RealEstate Id ....." + widget.realEstateId.toString());
    print("Report Content ....." + _reportContent);

    try {
      // setState(() {
      //   _isLoading = true;
      // });

      await Provider.of<MassagesProvider>(context, listen: false).postReport(
        reaEstateId: widget.realEstateId,
        reportContent: _reportContent,
        userId: _userData.userId,
      );

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
              "سيتم التحقق بشأن هذا الابلاغ ",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () {},
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
      // setState(() {
      //   _isLoading = false;
      // });
    } catch (e) {
      // setState(() {
      //   _isLoading = false;
      // });
      // showDialog(
      //   context: context,
      //   builder: (ctx) => AlertDialog(
      //     // title:
      //     content: Text("يوجد خطأ الرجاء المحاولة لاحقا"),
      //     actions: [
      //       FlatButton(
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //         child: Text("Ok"),
      //       ),
      //     ],
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          " الابلاغ",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "محتوى البـلاغ :",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              BuilFormField(
                textInputAction: TextInputAction.done,
                contentPadding: 8.0,
                keyboardType: TextInputType.multiline,
                hintText: "اكتب التفاصيل البـلاغ هنا",
                hintStyle: TextStyle(
                  fontSize: 13,
                  wordSpacing: 2,
                ),
                maxLines: 3,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return "الرجاء كتابة تفاصيل البلاغ ";
                  }
                },
                onSaved: (value) {
                  _reportContent = value;
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
                  child: _isLoading
                      ? showDialog(
                          context: context,
                          builder: (ctx) => GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {},
                            child: Center(
                              child: sleekCircularSlider(
                                context,
                                30,
                                AppColors.primaryColor,
                                AppColors.scondryColor,
                              ),
                            ),
                          ),
                        )
                      : Text(
                          "ارسال البـلاغ",
                          style: TextStyle(
                            fontSize: isLandScape
                                ? screenUtil.setSp(25)
                                : screenUtil.setSp(40),
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
    );
  }
}
