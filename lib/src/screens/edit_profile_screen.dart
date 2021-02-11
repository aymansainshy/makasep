import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/app_constant.dart';
import '../lang/language_provider.dart';

// enum ImageType {
//   GALLERY,
//   CAMERA,
// }

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit-profile-screen';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  var isVisible = false;
  var isPasswordHide = true;
  var isLoading = false;
  AuthProvider _userData;
  String _userImage;
  File _storedImage;

  void _showArrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(translate("errorOccurred", context)),
        content: Text(message),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(translate("ok", context)))
        ],
      ),
    );
  }

  var _editedData = {
    'name': '',
    'address': '',
    'email': '',
    'password': '',
    'phoneNumber': '',
  };

  @override
  void initState() {
    _userData = Provider.of<AuthProvider>(context, listen: false);
    _editedData['name'] = _userData.userName;
    _editedData['address'] = _userData.userAddress;
    _editedData['password'] = _userData.password;
    _editedData['phoneNumber'] = _userData.userPhone;
    _userImage = _userData.imageUrl;

    super.initState();
  }

  void _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    print(_editedData['email']);
    print(_editedData['password']);
    print(_editedData['phoneNumber']);
    print(_editedData['address']);
    print(_editedData['name']);
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false).updataUser(
        userId: _userData.userId,
        userName: _editedData['name'],
        userPassword: _editedData['password'],
        userAddress: _editedData['address'],
        userPhone: _editedData['phoneNumber'],
      );
      if (_storedImage != null) {
        print("Image Path ........." + _storedImage.path.toString());
        await Provider.of<AuthProvider>(context, listen: false).uploadImage(
          image: _storedImage,
          userId: _userData.userId,
        );
      }
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } on HttpException catch (e) {
      if (e.toString() == '12') {
        _showArrorDialog("Image is too larg");
      }
      if (e.toString() == '5') {
        _showArrorDialog("Image is too larg");
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      var errorMessage = translate("anErrorPleaseTryLater", context);
      if (e.toString() == '12') {
        errorMessage = translate("imagIsTooLarg", context);
      }
      _showArrorDialog(errorMessage);
      setState(() {
        isLoading = false;
      });
    }

    // _formKey.currentState.reset();
  }

  final _picker = ImagePicker();
  Future _picImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _storedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    ScreenUtil screenUtil = ScreenUtil();

    final langugeProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    final language = langugeProvider.appLocal.languageCode;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 68,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).accentIconTheme,
        // iconTheme: Theme.of(context).iconTheme,
        // backgroundColor: Color.fromARGB(0, 0, 0, 1),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          translate("editProfile", context),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: AppColors.primaryColor,
        icon: Text(
          translate("save", context),
          style: TextStyle(
            fontSize: isLandScape ? screenUtil.setSp(25) : screenUtil.setSp(35),
          ),
        ),
        label: isLoading
            ? Center(
                child: sleekCircularSlider(context, screenUtil.setSp(80),
                    AppColors.primaryColor, AppColors.scondryColor),
              )
            : Icon(
                Icons.check,
                size: isLandScape ? screenUtil.setSp(30) : screenUtil.setSp(40),
              ),
        onPressed: isLoading ? null : _saveForm,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        isExtended: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 80),
            child: Column(
              children: [
                Container(
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        height: isLandScape
                            ? screenUtil.setHeight(600)
                            : screenUtil.setHeight(400),
                        width: isLandScape
                            ? screenUtil.setWidth(250)
                            : screenUtil.setWidth(400),
                        decoration: BoxDecoration(
                          color: AppColors.scondryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: _storedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.file(
                                  _storedImage,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: _userImage == null
                                    ? Container()
                                    : Image.network(
                                        _userImage,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: -15,
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            size: isLandScape
                                ? screenUtil.setWidth(40)
                                : screenUtil.setSp(80),
                            color: AppColors.primaryColor,
                          ),
                          onPressed: _picImage,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(4),
                              labelText: translate('userName', context),
                            ),
                            cursorColor: Colors.grey.shade300,
                            initialValue: _userData.userName,
                            validator: (value) {
                              if (value.isEmpty) {
                                return translate("enterYourFullName", context);
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedData['name'] = value;
                            },
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(4),
                              labelText: translate('address', context),
                            ),
                            cursorColor: Colors.grey.shade300,
                            initialValue: _userData.userAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return translate(
                                    "enterYourFullAddress", context);
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedData['address'] = value;
                            },
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            obscureText: isPasswordHide,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(4),
                              labelText: translate('password', context),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                    isPasswordHide = !isPasswordHide;
                                  });
                                },
                              ),
                            ),
                            cursorColor: Colors.grey.shade300,
                            initialValue: _userData.password,
                            validator: (value) {
                              if (value.isEmpty) {
                                return translate("enterPassword", context);
                              }
                              if (value.toString().length < 5) {
                                return translate("enterValidPassword", context);
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedData['password'] = value;
                            },
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(4),
                              labelText: translate('phone', context),
                            ),
                            keyboardType: TextInputType.phone,
                            cursorColor: Colors.grey.shade300,
                            initialValue: _userData.userPhone,
                            validator: (value) {
                              if (value.isEmpty) {
                                return translate(
                                    "enterYourPhoneNumber", context);
                              }

                              if (value.toString().length < 8) {
                                return translate("PhoneNumberValid", context);
                              }

                              if (!value.toString().startsWith('+') &&
                                  !value.toString().startsWith('0')) {
                                return translate("validPhone", context);
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _editedData['phoneNumber'] = value;
                            },
                          ),
                        ],
                      ),
                    ),
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
