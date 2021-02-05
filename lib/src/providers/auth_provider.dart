import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {
  Dio _dio = Dio();
  String userId;
  String userName;
  String userPhone;
  String userAddress;
  String _userPassword;
  String _userToken;
  String imageUrl;
  String rating;
  String showContact;
  String userTypeId;
  String available;

  bool get isAuth {
    print('Rebuilding ............');
    print("Tookeeeeeeeeeeeeeeeen is " + _userToken.toString());
    // return userId != null;
    return _userToken != null;
  }

  String get password {
    return _userPassword;
  }

  Future<void> _authenticat(String urls, Map<String, dynamic> data) async {
    print('Authenticating ............');

    final url = urls;
    try {
      final response = await _dio.post(
        url,
        options: Options(
          sendTimeout: 2000,
          receiveTimeout: 1000,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
        ),
        data: data,
      );

      print("Response Date.... " + response.toString());
      print("ResponseStatusCode .... " + response.statusCode.toString());

      final responseData = response.data as Map<String, dynamic>;

      userId = responseData["id"].toString();
      userName = responseData["user_name"];
      userPhone = responseData["phone_number"].toString();
      userAddress = responseData["address"];
      _userPassword = responseData["password"].toString();
      _userToken = responseData["remember_token"];
      imageUrl = responseData["image"];
      rating = responseData["rating"].toString();
      showContact = responseData["show_contact"].toString();
      userTypeId = responseData["user_type_id"].toString();
      available = responseData["available"].toString();
      notifyListeners();

      /// [*] Storing data after logIn.... for [Auto log in] .......
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        "userId": responseData["id"].toString(),
        "userName": responseData["user_name"],
        "userPhone": responseData["phone_number"].toString(),
        "userAddress": responseData["address"],
        "userPassword": responseData["password"].toString(),
        "userToken": responseData["remember_token"],
        "imageUrl": responseData["image"],
        "rating": responseData["rating"].toString(),
        "showContact": responseData["show_contact"].toString(),
        "userTypeId": responseData["user_type_id"].toString(),
        "available": responseData["available"].toString(),
      });
      prefs.setString('userData', userData);
    } on DioError catch (e) {
      print("Catch Dio error " + e.response.data['code'].toString());
      throw HttpException(e.response.data['code'].toString());
    } catch (e) {
      print("Catch " + e.toString());
      throw e.toString();
    }
  }

  Future<void> register(
      {String name, String address, String phone, String password}) async {
    final url = 'http://162.0.230.58/api/Customer';
    var data = {
      "user_name": name,
      "password": password,
      "phone_number": phone,
      "address": address,
    };

    return _authenticat(url, data);
  }

  Future<void> login({String phone, String password}) async {
    final url = 'http://162.0.230.58/api/Customer/login';
    var data = {
      "phone_number": phone,
      "password": password,
    };

    return _authenticat(url, data);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      return false;
    }
    final _userData =
        json.decode(prefs.getString("userData")) as Map<String, dynamic>;
    userId = _userData["userId"];
    userName = _userData["userName"];
    userPhone = _userData["userPhone"];
    userAddress = _userData["userAddress"];
    _userPassword = _userData["userPassword"];
    _userToken = _userData["userToken"];
    imageUrl = _userData["imageUrl"];
    rating = _userData["rating"];
    showContact = _userData["showContact"];
    userTypeId = _userData["userTypeId"];
    available = _userData["available"];
    notifyListeners();
    return true;
  }

  Future<void> logOut() async {
    _userToken = null;
    userId = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userData");
  }

  Future<void> updataUser({
    @required String userId,
    @required String userName,
    @required String userPassword,
    @required String userPhone,
    @required String userAddress,
  }) async {
    final url = 'http://162.0.230.58/api/Customer/$userId';

    Map<String, dynamic> data = {
      "user_name": userName,
      "address": userAddress,
      "phone_number": userPhone,
      "password": userPassword,
    };

    try {
      final response = await _dio.put(
        url,
        data: jsonEncode(data),
        options: Options(
          sendTimeout: 2000,
          receiveTimeout: 1000,
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final responseData = response.data as Map<String, dynamic>;

      /// [*] Storing data after logIn.... for [Auto log in] .......
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey("userData")) {
        return;
      }
      prefs.remove("userData");

      final userData = json.encode({
        "userId": responseData["id"].toString(),
        "userName": responseData["user_name"],
        "userPhone": responseData["phone_number"].toString(),
        "userAddress": responseData["address"],
        "userPassword": responseData["password"].toString(),
        "userToken": responseData["remember_token"],
        "imageUrl": responseData["image"],
        "rating": responseData["rating"].toString(),
        "showContact": responseData["show_contact"].toString(),
        "userTypeId": responseData["user_type_id"].toString(),
        "available": responseData["available"].toString(),
      });
      prefs.setString("userData", userData);
      await tryAutoLogin();
    } on DioError catch (e) {
      print("Dio Error ......." + e.response.statusCode.toString());
      throw HttpException(e.response.data['code'].toString());
    } catch (e) {
      print("Error ......." + e.response.statusMessage);
      throw e;
    }
  }

  Future<void> uploadImage({File image, String userId}) async {
    final url = 'http://162.0.230.58/api/Customer/$userId/imageUpdate';
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image_url": await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ),
      });

      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          sendTimeout: 2000,
          receiveTimeout: 1000,
          headers: {
            'content-type': 'multipart/form-data',
            'Accept': '*/*',
          },
        ),
      );
      final responseData = response.data as Map<String, dynamic>;

      /// [*] Storing data after logIn.... for [Auto log in] .......
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey("userData")) {
        return;
      }
      prefs.remove("userData");

      final userData = json.encode({
        "userId": responseData["id"].toString(),
        "userName": responseData["user_name"],
        "userPhone": responseData["phone_number"].toString(),
        "userAddress": responseData["address"],
        "userPassword": responseData["password"].toString(),
        "userToken": responseData["remember_token"],
        "imageUrl": responseData["image"],
        "rating": responseData["rating"].toString(),
        "showContact": responseData["show_contact"].toString(),
        "userTypeId": responseData["user_type_id"].toString(),
        "available": responseData["available"].toString(),
      });
      prefs.setString("userData", userData);
      await tryAutoLogin();
    } on DioError catch (e) {
      throw HttpException(e.response.data['code'].toString());
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> forgetPassword(String email) async {
    final url = 'http://backend.bdcafrica.site/api/user/forgetpassword';
    try {
      final response = await _dio.post(
        url,
        data: jsonEncode(email),
        options: Options(
          sendTimeout: 2000,
          receiveTimeout: 1000,
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print("Response Data .........." + response.data.toString());
      print("Response Stause Code .........." + response.statusCode.toString());
      print("Response Message .......... " + response.statusMessage.toString());
    } on DioError catch (e) {
      print("Catch E " + e.toString());
    }
  }
}
