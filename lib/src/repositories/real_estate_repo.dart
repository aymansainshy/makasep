import 'package:dio/dio.dart';

import '../models/real_estate_model.dart';

class RealEstateRepo {
  Dio dio = Dio();

  ///[CatId, FilterUrl, FilterId] ///////.................
  ///
  ///
  Future<List<RealEstate>> fetchRealStates(
      String catId, String fliterId, int selectedUrl) async {
    print("Cat id //////////////  " + catId);
    print("Filter id //////////////  " + fliterId);
    print("Selected Url id //////////////  " + selectedUrl.toString());

    var url = "";

    if (selectedUrl == 0) {
      url = "http://162.0.230.58/api/realEstate/secondry/$fliterId";
    }
    if (selectedUrl == 1) {
      url = "http://162.0.230.58/api/realEstate/secondry/$fliterId/byPrice";
    }
    if (selectedUrl == 2) {
      url = "http://162.0.230.58/api/realEstate/secondry/$fliterId/bySpace";
    }

    print("Selected Url String //////////////  " + url.toString());
    print("Start Fetching RealStates ..... ");

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
    print("Response Body .. " + response.data.toString());
    final _respostDate = response.data as List<dynamic>;

    List<RealEstate> _loadedRealStates = [];
    _respostDate.forEach(
      (e) {
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
      },
    );

    return _loadedRealStates;
  }

  RealEstate _realEstate = RealEstate(
    id: "",
    area: 0.0,
    categoryType: "",
    description: "",
    imageUrl: "",
    owner: "",
    price: 0.0,
    type: 1,
    address: Address(
      lan: 0.0,
      lat: 0.0,
      locationDescription: "",
    ),
    details: RealEstateDetails(
      bathroom: 1,
      hall: 2,
      old: "",
      rooms: 1,
      steps: 1,
      views: 0,
      elevator: false,
      ketchen: false,
      mafrosha: false,
      parking: false,
      airConditioner: false,
    ),
  );

  RealEstate get realEstate => _realEstate;

  void setRealEstateHall(int hallCount) {
    _realEstate.details.hall = hallCount;

    print(" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< " +
        _realEstate.details.hall.toString());
  }
}
