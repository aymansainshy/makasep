import 'package:flutter/cupertino.dart';

import '../models/category_model.dart';

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
      title: "استثمار",
      imageUrl: "assets/icons/business.png",
    ),
    Category(
      id: "5",
      title: "ايجار",
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
}
