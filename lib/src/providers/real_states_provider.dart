import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/real_estate_model.dart';

class RealStatesProvider with ChangeNotifier {
  final String userId = "2";
  var isLoading = false;
  Dio dio = Dio();

  List<RealEstate> _realStates = [];

  List<RealEstate> get realStates => [..._realStates];

  Future<void> fetchRealStates(String catId, String fliterId) async {
    final url = "http://162.0.230.58/api/realEstate/secondry/$fliterId";

    print("Start Fetching RealStates ..... ");
    try {
      isLoading = true;
      notifyListeners();
      final response = await dio.get(
        url,
        queryParameters: {
          'primary_type_id': catId,
        },
        options: Options(
          sendTimeout: 2000,
          receiveTimeout: 1000,
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      isLoading = false;
      notifyListeners();
      print("Response Body .. " + response.data.toString());
      final _respostDate = response.data as List<dynamic>;

      List<RealEstate> _loadedRealStates = [];
      _respostDate.forEach((e) {
        _loadedRealStates.add(
          RealEstate(
            id: e["id"].toString(),
            categoryType: e["primary_type_id"].toString(),
            price: double.parse(e["price"].toString()),
            owner: e["user_id"].toString(),
            area: double.parse(e["space"].toString()),
            description: e["describstion"],
            imageUrl: e["image"],
            type: int.parse(e["primary_type_id"].toString()),
            address: Address(
              lat: e["lat"],
              lan: e["long"],
            ),
            details: RealEstateDetails(
              hall: int.parse(e["halls_num"].toString()),
              rooms: int.parse(e["room_num"].toString()),
              views: int.parse(e["watching_time"].toString()),
              old: e["bulding_age"].toString(),
              steps: int.parse(e["floor_num"].toString()),
              bathroom: 2, //api null
              airConditioner: e["Conditioners"] == "0" ? false : true,
              elevator: e["elevator"] == "0" ? false : true,
              ketchen: e["kitchen"] == "0" ? false : true,
              parking: e["car_door"] == "0" ? false : true,
              mafrosha: e["Furnished"] == "0" ? false : true,
            ),
          ),
        );
      });

      _realStates = _loadedRealStates;
      notifyListeners();
      print("RealState List ...... " + _realStates.toString());
    } catch (e) {
      print("Error Massage ......." + e.toString());
    }
  }
}
