import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/post_realEstate/post_realestate_bloc.dart';
import '../widgets/build_form_field.dart';
import '../providers/auth_provider.dart';
import '../utils/app_constant.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();

  AuthProvider _userData;
  String _reportContent;
  var isInit = true;

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
          child: SingleChildScrollView(
              child: BlocConsumer<PostRealestateBloc, PostRealestateState>(
            listener: (context, state) {
              if (state is PostRealestateInprogress) {
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
              if (state is PostRealestateDone) {
                Navigator.of(context).pop();
                _formKey.currentState.reset();

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
              }

              if (state is PostRealestateError) {
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
                      setState(() {
                        _reportContent = value;
                      });
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
              );
            },
          )),
        ),
      ),
    );
  }
}
