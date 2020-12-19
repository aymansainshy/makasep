import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_constant.dart';
import '../screens/sign_up_screen.dart';
import '../widgets/build_form_field.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login-screen';

  final bool isSingUp;

  const LoginScreen({
    Key key,
    this.isSingUp = false,
  }) : super(key: key);
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
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "Log in",
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
              LogInForm(isSingUp, isLandScape, screenUtil),
              SizedBox(
                height: screenUtil.setHeight(150),
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
  final _passwordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  var isVisible = false;
  var isPasswordHide = true;

  var logInData = {
    'phoneNumber': '',
    'password': '',
  };

  void _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    print(logInData['email']);
    print(logInData['password']);
  }

  // RegExp _isEmailValid = RegExp(
  //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          children: [
            BuilFormField(
              fieldName: "Phone ",
              contentPadding: 8.0,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                  width: widget.screenUtil.setWidth(180),
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // color: Colors.blue,
                        height: widget.screenUtil.setHeight(40),
                        width: widget.screenUtil.setWidth(50),
                        child: Image.asset(
                          "assets/images/sudan-flag.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      // Spacer(),
                      FittedBox(
                        child: Text(
                          "+249",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),

                      Container(
                        height: widget.screenUtil.setHeight(100),
                        width: 0.55645555,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
              ),
              focusNode: _phoneFocusNode,
              onFieldSubmitted: (_) {
                _saveForm();
              },
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter your phone number ";
                }

                if (value.toString().length < 8) {
                  return "Please enter avalid phone number";
                }

                if (!value.toString().startsWith('+') &&
                    !value.toString().startsWith('0')) {
                  return "your phone number don't match the pattren";
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
              fieldName: "Password",
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
                  return "Please enter password";
                }
                if (value.toString().length < 6) {
                  return "Your password must be at last 7 char";
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
                child: Text(
                  "Log in",
                  style: TextStyle(
                    fontSize: widget.isLandScape
                        ? widget.screenUtil.setSp(25)
                        : widget.screenUtil.setSp(45),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  // _saveForm();
                  Navigator.of(context).pushNamed(SignUpScreen.routeName);
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
                  color: AppColors.primaryColor,
                  width: 1.0,
                ),
              ),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.white,
                textColor: AppColors.primaryColor,
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: widget.isLandScape
                        ? widget.screenUtil.setSp(25)
                        : widget.screenUtil.setSp(45),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  // _saveForm();
                  Navigator.of(context).pushNamed(SignUpScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
