import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../widgets/build_form_field.dart';
import '../providers/auth_provider.dart';
// import '../lang/language_provider.dart';
import '../screens/sign_up_screen.dart';
import '../models/http_exception.dart';
import '../screens/home_screen.dart';
import '../utils/app_constant.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  final bool isSingUp;

  const LoginScreen({
    Key key,
    this.isSingUp = false,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   Provider.of<RealStatesProvider>(context, listen: false)
  //       .fetchRealStates("1", "1");
  // }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    ScreenUtil screenUtil = ScreenUtil();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenUtil.setHeight(100),
              ),
              Center(
                child: Transform.translate(
                  offset: Offset(0, 25),
                  child: Container(
                    child: Hero(
                      tag: 'logoAnimation',
                      child: Image.asset(
                        'assets/images/makasep_logo.png',
                        fit: BoxFit.cover,
                        // color: Colors.grey,
                        height: isLandScape
                            ? screenUtil.setHeight(700)
                            : screenUtil.setHeight(600),
                        width: isLandScape
                            ? screenUtil.setHeight(700)
                            : screenUtil.setHeight(800),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenUtil.setHeight(50),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Text(
                  "انشاء حساب",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: isLandScape
                        ? screenUtil.setSp(30)
                        : screenUtil.setSp(50),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: screenUtil.setHeight(40),
              ),
              LogInForm(widget.isSingUp, isLandScape, screenUtil),
              SizedBox(
                height: screenUtil.setHeight(80),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LogInForm extends StatefulWidget {
  final bool isSignUp;
  final bool isLandScape;
  final ScreenUtil screenUtil;

  const LogInForm(
    this.isSignUp,
    this.isLandScape,
    this.screenUtil,
  );
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  var isVisible = false;
  var isPasswordHide = true;
  var isLoading = false;

  var logInData = {
    'phoneNumber': '',
    'password': '',
  };

  void _showArrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("An error accured "),
        content: Text(message),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ok"))
        ],
      ),
    );
  }

  void _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    print(logInData['phoneNumber']);
    print(logInData['password']);

    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false).login(
        phone: logInData['phoneNumber'],
        password: logInData['password'],
      );
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } on HttpException catch (e) {
      setState(() {
        isLoading = false;
      });
      var errorMessage = translate("anErrorPleaseTryLater", context);
      if (e.toString() == '0') {
        errorMessage = translate("thisPasswordInCorrect", context);
      } else if (e.toString() == '1') {
        errorMessage = "رقم الهاتف غير صحيح";
      }
      _showArrorDialog(errorMessage);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      final errorMessage = translate("anErrorPleaseTryLater", context);
      _showArrorDialog(errorMessage);
    }

    // _formKey.currentState.reset();
  }

  // RegExp _isEmailValid = RegExp(
  //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  RegExp _isPhoneValid =
      RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          children: [
            BuilFormField(
              fieldName: "رقم الهاتف ",
              contentPadding: 8.0,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              prefixIcon: Icon(Icons.phone),
              focusNode: _phoneFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return "الرجاء ادخال رقم هاتفك ";
                }

                if (value.toString().length < 8) {
                  return "الرجاء ادخال رقم هاتف صحيح";
                }

                if (!_isPhoneValid.hasMatch(value)) {
                  return "الرجاء ادخال رقم هاتف صحيح";
                }

                return null;
              },
              onSaved: (value) {
                logInData['phoneNumber'] = value;
              },
            ),
            SizedBox(
              height: widget.screenUtil.setHeight(50),
            ),
            BuilFormField(
              contentPadding: 8.0,
              fieldName: "كلمة السر",
              keyboardType: TextInputType.visiblePassword,
              obscureText: isPasswordHide,
              textInputAction: TextInputAction.done,
              focusNode: _passwordFocusNode,
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                    isPasswordHide = !isPasswordHide;
                  });
                },
              ),
              onFieldSubmitted: (_) {
                _saveForm();
              },
              validator: (value) {
                if (value.isEmpty) {
                  return "الرجاء اخال كلمة السر";
                }
                if (value.toString().length < 5) {
                  return "كلمة السر يجب ان لا تقل عن 5 احرف";
                }
                return null;
              },
              onSaved: (value) {
                logInData['password'] = value;
              },
            ),
            SizedBox(
              height: widget.screenUtil.setHeight(100),
            ),
            Container(
              width: double.infinity,
              height: widget.isLandScape
                  ? widget.screenUtil.setHeight(230)
                  : widget.screenUtil.setHeight(150),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: AppColors.primaryColor,
                textColor: Colors.white,
                child: isLoading
                    ? Center(
                        child: sleekCircularSlider(
                            context,
                            widget.screenUtil.setSp(80),
                            AppColors.primaryColor,
                            AppColors.scondryColor),
                      )
                    : Text(
                        "تسجيل دخول ",
                        style: TextStyle(
                          fontSize: widget.isLandScape
                              ? widget.screenUtil.setSp(25)
                              : widget.screenUtil.setSp(45),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                onPressed: () {
                  _saveForm();
                  // Navigator.of(context).pushNamed(HomeScreen.routeName);
                },
              ),
            ),
            SizedBox(
              height: widget.screenUtil.setHeight(50),
            ),
            Container(
              width: double.infinity,
              height: widget.isLandScape
                  ? widget.screenUtil.setHeight(230)
                  : widget.screenUtil.setHeight(150),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(
                  color: AppColors.scondryColor,
                  width: 1.0,
                ),
              ),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.white,
                textColor: AppColors.scondryColor,
                child: Text(
                  "انشاء حساب",
                  style: TextStyle(
                    fontSize: widget.isLandScape
                        ? widget.screenUtil.setSp(25)
                        : widget.screenUtil.setSp(45),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SignUpScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
