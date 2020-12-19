import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_constant.dart';
import '../screens/login_screen.dart';
import '../widgets/build_form_field.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/sign-up-screen';
  final bool isLogin;

  const SignUpScreen({
    Key key,
    this.isLogin = false,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "Sign Up",
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
                height: screenUtil.setHeight(30),
              ),
              SignUpForm(isLogin, isLandScape, screenUtil),
              SizedBox(
                height: screenUtil.setHeight(50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  final bool isLandScape;
  final ScreenUtil screenUtil;
  final bool isLogin;

  SignUpForm(
    this.isLogin,
    this.isLandScape,
    this.screenUtil,
  );
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _animationController2;
  Animation<double> _opacity;
  Animation<Offset> _slidAnimation;
  Animation<Offset> _slidAnimation2;

  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _passwordController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  var isVisible = false;
  var isPasswordHide = true;
  var isLoading = false;

  var signUpData = {
    'name': '',
    'address': '',
    'email': '',
    'password': '',
    'phoneNumber': '',
  };

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animationController2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController2,
        curve: Curves.easeIn,
      ),
    );
    _slidAnimation = Tween<Offset>(
      begin: Offset(-5, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
    _slidAnimation2 = Tween<Offset>(
      begin: Offset(5, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordController.dispose();
    _confirmPasswordFocusNode.dispose();
    _animationController.dispose();
    _animationController2.dispose();
    super.dispose();
  }

  // void _showArrorDialog(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: Text("an error accured"),
  //       content: Text(message),
  //       actions: [
  //         FlatButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("Ok"))
  //       ],
  //     ),
  //   );
  // }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    print('user name : ' + signUpData['name']);
    print('user address : ' + signUpData['address']);
    print('user phoneNumber : ' + signUpData['phoneNumber']);
    print('user email : ' + signUpData['email']);
    print('user password : ' + signUpData['password']);

    // _formKey.currentState.reset();
  }

  // RegExp _isEmailValid = RegExp(
  //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    _animationController2.forward();
    ScreenUtil.init(context);
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    ScreenUtil screenUtil = ScreenUtil();
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SlideTransition(
              position: _slidAnimation2,
              child: BuilFormField(
                fieldName: "Full Name",
                contentPadding: 8.0,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                // prefixIcon: Icon(Icons.person_outline),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter your name please";
                  }
                  return null;
                },
                onSaved: (value) {
                  signUpData['name'] = value;
                },
              ),
            ),
            SizedBox(
              height: widget.screenUtil.setHeight(50),
            ),
            SlideTransition(
              position: _slidAnimation,
              child: BuilFormField(
                fieldName: "Adrress",
                contentPadding: 8.0,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                // prefixIcon: Icon(Icons.location_on),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter your full adrress";
                  }
                  return null;
                },
                onSaved: (value) {
                  signUpData['address'] = value;
                },
              ),
            ),
            SizedBox(
              height: widget.screenUtil.setHeight(50),
            ),
            SlideTransition(
              position: _slidAnimation2,
              child: BuilFormField(
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
                  signUpData['phoneNumber'] = value;
                },
              ),
            ),
            SizedBox(
              height: widget.screenUtil.setHeight(50),
            ),
            SlideTransition(
              position: _slidAnimation,
              child: BuilFormField(
                fieldName: "Password",
                contentPadding: 8.0,
                obscureText: isPasswordHide,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                // prefixIcon: Icon(Icons.lock_outline),
                focusNode: _passwordFocusNode,
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
                  FocusScope.of(context)
                      .requestFocus(_confirmPasswordFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter your password";
                  }
                  if (value.toString().length < 6) {
                    return "Password must be at last 7 character";
                  }
                  return null;
                },
                onSaved: (value) {
                  signUpData['password'] = value;
                },
              ),
            ),
            SizedBox(
              height: widget.screenUtil.setHeight(50),
            ),
            SlideTransition(
              position: _slidAnimation2,
              child: BuilFormField(
                fieldName: "Confirme Password",
                contentPadding: 8.0,
                obscureText: isPasswordHide,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                // prefixIcon: Icon(Icons.lock_outline),
                focusNode: _confirmPasswordFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_phoneFocusNode);
                },
                validator: (value) {
                  if (value != _passwordController.text) {
                    return "Password don't match ";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: widget.screenUtil.setHeight(60),
            ),
            FadeTransition(
              opacity: _opacity,
              child: Container(
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
                    "Sign Up",
                    style: TextStyle(
                      fontSize: widget.isLandScape
                          ? widget.screenUtil.setSp(25)
                          : widget.screenUtil.setSp(45),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    _saveForm();
                    // Navigator.of(context).pushNamed(TapScreen.routeName);
                  },
                ),
              ),
            ),
            SizedBox(
              height: widget.screenUtil.setHeight(60),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "I Have Account ",
                    style: TextStyle(
                      fontSize: isLandScape
                          ? screenUtil.setSp(28)
                          : screenUtil.setSp(40),
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    child: Text(
                      "Sign In ",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: isLandScape
                            ? screenUtil.setSp(28)
                            : screenUtil.setSp(40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
