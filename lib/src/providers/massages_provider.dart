import 'package:flutter/material.dart';

import '../models/massages_model.dart';

class MassagesProvider with ChangeNotifier {
  List<Massege> _massages = [
    Massege(
      id: "1",
      senderId: "1",
      reseverId: "2",
      content: "هاااااي",
    ),
    Massege(
      id: "2",
      senderId: "2",
      reseverId: "1",
      content: "اهلا وسهلا",
    ),
    Massege(
      id: "3",
      senderId: "1",
      reseverId: "2",
      content: "عايز شقة ",
    ),
    Massege(
      id: "4",
      senderId: "2",
      reseverId: "1",
      content: " مواصفات الشقة شنو ؟",
    ),
  ];

  List<Massege> get massages {
    return [..._massages];
  }
}
