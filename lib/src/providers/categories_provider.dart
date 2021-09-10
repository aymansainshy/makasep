import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:makasep/src/models/secondryType.dart';

import '../models/category_model.dart';

Dio dio = Dio();

class CategoriesProvider with ChangeNotifier {
  final List<Category> _categoryList = [
    Category(
      id: "1",
      title: "الكل",
      imageUrl: "assets/icons/home.png",
    ),
    Category(
      id: "2",
      title: "عرض - بيع ",
      imageUrl: "assets/icons/selling.png",
    ),
    Category(
      id: "3",
      title: "شراء",
      imageUrl: "assets/icons/buying.png",
    ),
    Category(
      id: "4",
      title: "إستثمار",
      imageUrl: "assets/icons/business.png",
    ),
    Category(
      id: "5",
      title: "إيجار",
      imageUrl: "assets/icons/balance.png",
    ),
    Category(
      id: "6",
      title: "تقبيل - خلو طرف",
      imageUrl: "assets/icons/key.png",
    ),
    Category(
      id: "7",
      title: "البناء والمقاولات",
      imageUrl: "assets/icons/build.png",
    ),
    Category(
      id: "8",
      title: "مواقع مهمة",
      imageUrl: "assets/icons/important.png",
    ),
    Category(
      id: "9",
      title: "أخرى",
      imageUrl: "assets/icons/plus.png",
    ),
  ];

  List<Category> get categoryList {
    return [..._categoryList];
  }

  final List<Category> _categoryPostList = [
    Category(
      id: "2",
      title: "عرض - بيع ",
      imageUrl: "assets/icons/selling.png",
    ),
    Category(
      id: "3",
      title: "شراء",
      imageUrl: "assets/icons/buying.png",
    ),
    Category(
      id: "4",
      title: "إستثمار",
      imageUrl: "assets/icons/business.png",
    ),
    Category(
      id: "5",
      title: "إيجار",
      imageUrl: "assets/icons/balance.png",
    ),
    Category(
      id: "6",
      title: "تقبيل - خلو طرف",
      imageUrl: "assets/icons/key.png",
    ),
    Category(
      id: "7",
      title: "البناء والمقاولات",
      imageUrl: "assets/icons/build.png",
    ),
    Category(
      id: "8",
      title: "مواقع مهمة",
      imageUrl: "assets/icons/important.png",
    ),
    Category(
      id: "9",
      title: "أخرى",
      imageUrl: "assets/icons/plus.png",
    ),
  ];

  List<Category> get categoryPostList {
    return [..._categoryPostList];
  }

  List<SecondryType> _secondryType = [];

  List<SecondryType> get secondryType {
    return [..._secondryType];
  }

  Future<void> fetchType() async {
    final url = 'https://makaseib.website/api/secondry';
    try {
      final _response = await dio.get(
        url,
        options: Options(
          sendTimeout: 5000,
          receiveTimeout: 5000,
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print("Restpons Body ..... " + _response.data.toString());
      final _respostDate = _response.data as List<dynamic>;

      List<SecondryType> _loadedType = [];
      _respostDate.forEach(
        (e) {
          _loadedType.add(
            SecondryType.fromJson(e),
          );
        },
      );

      _secondryType = _loadedType;
      notifyListeners();
    } catch (e) {
      if (e.response != null) {
        print("RESPONSE Error Respons Data == " + e.response.data.toString());
        print("RESPONSE Error Respons Status massege == " +
            e.response.statusMessage.toString());
        print("RESPONSE Error Response Request == " +
            e.response.request.uri.toString());
      }
      print("ERROR Error error == " + e.error.toString());
      print("ERROR Error request == " + e.request.uri.toString());
      print("ERROR Error type == " + e.type.toString());
      print("ERROR Error massege == " + e.message.toString());
      throw e.toString();
    }
  }
}
