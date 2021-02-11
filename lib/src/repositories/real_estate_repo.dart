import 'dart:io';

import 'package:dio/dio.dart';
import 'dart:convert';

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

    final _response = await dio.get(
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
    print("Response Body .. " + _response.data.toString());
    final _respostDate = _response.data as List<dynamic>;

    List<RealEstate> _loadedRealStates = [];
    _respostDate.forEach(
      (e) {
        _loadedRealStates.add(
          RealEstate(
            id: e["id"].toString(),
            categoryType: e["primary_type_id"].toString(),
            price: double.parse(e["price"].toString()),
            owner: e["user_id"].toString(),
            area: e["space"].toString(),
            description: e["describstion"],
            imageUrl: 'http://162.0.230.58' + e["image"],
            type: int.parse(e["secondry_type_id"].toString()),
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
              bathroom: int.parse(e["path_room"].toString()),
              airConditioner:
                  e["Conditioners"].toString() == "0" ? false : true,
              elevator: e["elevator"].toString() == "0" ? false : true,
              ketchen: e["kitchen"].toString() == "0" ? false : true,
              parking: e["car_door"].toString() == "0" ? false : true,
              mafrosha: e["Furnished"].toString() == "0" ? false : true,
            ),
          ),
        );
      },
    );

    return _loadedRealStates;
  }

  ///////////////////////////////////////////[ SIMELER REALESTATE ]////////////////////////////////////////////////////
  Future<List<RealEstate>> fetchSemilerRealStates(String realEstateId) async {
    final url = 'http://162.0.230.58/api/realestate/$realEstateId';

    print("Start Fetching SemilarRealStates ..... ");

    final _response = await dio.get(
      url,
      // queryParameters: {
      //   'primary_type_id': catId,
      // },
      options: Options(
        sendTimeout: 2000,
        receiveTimeout: 1000,
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    final _respostDate = _response.data['same'] as List<dynamic>;

    List<RealEstate> _loadedRealStates = [];
    _respostDate.forEach(
      (e) {
        _loadedRealStates.add(
          RealEstate(
            id: e["id"].toString(),
            categoryType: e["primary_type_id"].toString(),
            price: double.parse(e["price"].toString()),
            owner: e["user_id"].toString(),
            area: e["space"].toString(),
            description: e["describstion"],
            imageUrl: 'http://162.0.230.58' + e["image"],
            type: int.parse(e["secondry_type_id"].toString()),
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
              bathroom: int.parse(e["path_room"].toString()),
              airConditioner:
                  e["Conditioners"].toString() == "0" ? false : true,
              elevator: e["elevator"].toString() == "0" ? false : true,
              ketchen: e["kitchen"].toString() == "0" ? false : true,
              parking: e["car_door"].toString() == "0" ? false : true,
              mafrosha: e["Furnished"].toString() == "0" ? false : true,
            ),
          ),
        );
      },
    );

    return _loadedRealStates;
  }

  ////////////////////////////////[Fetch Last Call RealEstate ]//////////////////////////////////////

  Future<List<RealEstate>> fetchLastCallRealStates(String userId) async {
    final url = 'http://162.0.230.58/api/realEstate/lastViewed/$userId';

    final _response = await dio.get(
      url,
      // queryParameters: {
      //   'primary_type_id': catId,
      // },
      options: Options(
        sendTimeout: 2000,
        receiveTimeout: 1000,
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    final _respostDate = _response.data as List<dynamic>;

    List<RealEstate> _loadedRealStates = [];
    _respostDate.forEach(
      (e) {
        _loadedRealStates.add(
          RealEstate(
            id: e["real_estate"]["id"].toString(),
            categoryType: e["real_estate"]["primary_type_id"].toString(),
            price: double.parse(e["real_estate"]["price"].toString()),
            owner: e["real_estate"]["user_id"].toString(),
            area: e["real_estate"]["space"].toString(),
            description: e["real_estate"]["describstion"],
            imageUrl: 'http://162.0.230.58' + e["real_estate"]["image"],
            type: int.parse(e["real_estate"]["secondry_type_id"].toString()),
            address: Address(
              lat: e["real_estate"]["lat"],
              lan: e["real_estate"]["long"],
            ),
            details: RealEstateDetails(
              hall: int.parse(e["real_estate"]["halls_num"].toString()),
              rooms: int.parse(e["real_estate"]["room_num"].toString()),
              views: int.parse(e["real_estate"]["watching_time"].toString()),
              old: e["real_estate"]["bulding_age"].toString(),
              steps: int.parse(e["real_estate"]["floor_num"].toString()),
              bathroom: int.parse(e["real_estate"]["path_room"].toString()),
              airConditioner: e["real_estate"]["Conditioners"].toString() == "0"
                  ? false
                  : true,
              elevator:
                  e["real_estate"]["elevator"].toString() == "0" ? false : true,
              ketchen:
                  e["real_estate"]["kitchen"].toString() == "0" ? false : true,
              parking:
                  e["real_estate"]["car_door"].toString() == "0" ? false : true,
              mafrosha: e["real_estate"]["Furnished"].toString() == "0"
                  ? false
                  : true,
            ),
          ),
        );
      },
    );

    return _loadedRealStates;
  }

  /////////////////////////////////////[Fetch Today RealEstate ]////////////////////////////////////////

  Future<List<RealEstate>> fetchTodayRealStates() async {
    final url = 'http://162.0.230.58/api/realEstate/today';

    final _response = await dio.get(
      url,
      // queryParameters: {
      //   'primary_type_id': catId,
      // },
      options: Options(
        sendTimeout: 2000,
        receiveTimeout: 1000,
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    final _respostDate = _response.data as List<dynamic>;

    List<RealEstate> _loadedRealStates = [];
    _respostDate.forEach(
      (e) {
        _loadedRealStates.add(
          RealEstate(
            id: e["id"].toString(),
            categoryType: e["primary_type_id"].toString(),
            price: double.parse(e["price"].toString()),
            owner: e["user_id"].toString(),
            area: e["space"].toString(),
            description: e["describstion"],
            imageUrl: 'http://162.0.230.58' + e["image"],
            type: int.parse(e["secondry_type_id"].toString()),
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
              bathroom: int.parse(e["path_room"].toString()),
              airConditioner:
                  e["Conditioners"].toString() == "0" ? false : true,
              elevator: e["elevator"].toString() == "0" ? false : true,
              ketchen: e["kitchen"].toString() == "0" ? false : true,
              parking: e["car_door"].toString() == "0" ? false : true,
              mafrosha: e["Furnished"].toString() == "0" ? false : true,
            ),
          ),
        );
      },
    );

    return _loadedRealStates;
  }

  ////////////////////////////////////[Fetch Espcial RealEstate ]////////////////////////////////////////////

  Future<List<RealEstate>> fetchEspecialRealStates() async {
    final url = 'http://162.0.230.58/api/realEstate/special';

    final _response = await dio.get(
      url,
      // queryParameters: {
      //   'primary_type_id': catId,
      // },
      options: Options(
        sendTimeout: 2000,
        receiveTimeout: 1000,
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    final _respostDate = _response.data as List<dynamic>;

    List<RealEstate> _loadedRealStates = [];
    _respostDate.forEach(
      (e) {
        _loadedRealStates.add(
          RealEstate(
            id: e["id"].toString(),
            categoryType: e["primary_type_id"].toString(),
            price: double.parse(e["price"].toString()),
            owner: e["user_id"].toString(),
            area: e["space"].toString(),
            description: e["describstion"],
            imageUrl: 'http://162.0.230.58' + e["image"],
            type: int.parse(e["secondry_type_id"].toString()),
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
              bathroom: int.parse(e["path_room"].toString()),
              airConditioner:
                  e["Conditioners"].toString() == "0" ? false : true,
              elevator: e["elevator"].toString() == "0" ? false : true,
              ketchen: e["kitchen"].toString() == "0" ? false : true,
              parking: e["car_door"].toString() == "0" ? false : true,
              mafrosha: e["Furnished"].toString() == "0" ? false : true,
            ),
          ),
        );
      },
    );

    return _loadedRealStates;
  }

///////////////////////////////////////////[ Post Building And Contractor ]//////////////////////////////////////////////////

  Future<void> postBuildingAndContract({
    String usetId,
    String phoneNumber,
    String city,
    String description,
    String buildingTypeId,
  }) async {
    final url = 'http://162.0.230.58/api/Building';

    Map<String, dynamic> data = {
      "user_id": usetId,
      "phone_number": phoneNumber,
      "city": city,
      "desceribsion": description,
      "buliding_type_id": buildingTypeId,
    };
    // try {
    final response = await dio.post(
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

    print("Response Data .........." + response.data.toString());
    print("Response Stause Code .........." + response.statusCode.toString());
    print("Response Message .......... " + response.statusMessage.toString());
    // } catch (e) {
    //   print("Catch E " + e.toString());
    //   throw e.toString();
    // }
  }

///////////////////////////////////////////[ Post RealEsate Favorites ]//////////////////////////////////////////////////
  ///
  Future<void> postFavoriteRealEstate({
    String usetId,
    String realEstateId,
  }) async {
    final url = 'http://162.0.230.58/api/Customer/$usetId/favorit';

    print("Start Posting Favorites  ..........");

    Map<String, dynamic> data = {
      "real_estate_id": realEstateId,
    };
    // try {
    final response = await dio.post(
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

    print("Response Data .........." + response.data.toString());
    print("Response Stause Code .........." + response.statusCode.toString());
    print("Response Message .......... " + response.statusMessage.toString());
    // } catch (e) {
    //   print("Catch E " + e.toString());
    //   throw e.toString();
    // }
  }

  ////////////////////////////////////[Fetch Favorites RealEstate ]////////////////////////////////////////////

  Future<List<RealEstate>> fetchFavoritesRealStates({String userId}) async {
    final url = 'http://162.0.230.58/api/Customer/$userId/favorit';

    final _response = await dio.get(
      url,
      options: Options(
        sendTimeout: 2000,
        receiveTimeout: 1000,
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    final _respostDate = _response.data as List<dynamic>;

    List<RealEstate> _loadedRealStates = [];
    _respostDate.forEach(
      (e) {
        _loadedRealStates.add(
          RealEstate(
            id: e["real_estate"]["id"].toString(),
            categoryType: e["real_estate"]["primary_type_id"].toString(),
            price: double.parse(e["real_estate"]["price"].toString()),
            owner: e["real_estate"]["user_id"].toString(),
            area: e["real_estate"]["space"].toString(),
            description: e["real_estate"]["describstion"],
            imageUrl: 'http://162.0.230.58' + e["real_estate"]["image"],
            type: int.parse(e["real_estate"]["secondry_type_id"].toString()),
            address: Address(
              lat: e["real_estate"]["lat"],
              lan: e["real_estate"]["long"],
            ),
            details: RealEstateDetails(
              hall: int.parse(e["real_estate"]["halls_num"].toString()),
              rooms: int.parse(e["real_estate"]["room_num"].toString()),
              views: int.parse(e["real_estate"]["watching_time"].toString()),
              old: e["real_estate"]["bulding_age"].toString(),
              steps: int.parse(e["real_estate"]["floor_num"].toString()),
              bathroom: int.parse(e["real_estate"]["path_room"].toString()),
              airConditioner: e["real_estate"]["Conditioners"].toString() == "0"
                  ? false
                  : true,
              elevator:
                  e["real_estate"]["elevator"].toString() == "0" ? false : true,
              ketchen:
                  e["real_estate"]["kitchen"].toString() == "0" ? false : true,
              parking:
                  e["real_estate"]["car_door"].toString() == "0" ? false : true,
              mafrosha: e["real_estate"]["Furnished"].toString() == "0"
                  ? false
                  : true,
            ),
          ),
        );
      },
    );

    return _loadedRealStates;
  }

///////////////////////////////////////////[ Post RealEsate ]//////////////////////////////////////////////////
  ///
  Future<void> postRealEstate(
      {String userId, RealEstate realEstate, File image}) async {
    final url = 'http://162.0.230.58/api/realEstate';

    String fileName = image.path.split('/').last;
    // FormData formData = FormData.fromMap({
    //   "image": await MultipartFile.fromFile(
    //     image.path,
    //     filename: fileName,
    //   ),
    // });

    print("Start Posting RealEstate  ..........");

    FormData data = FormData.fromMap({
      "user_id": userId,
      "primary_type_id": realEstate.categoryType,
      "secondry_type_id": realEstate.type,
      "price": realEstate.price.toString(),
      "space": realEstate.area,
      "lat": realEstate.address.lat,
      "long": realEstate.address.lan,
      "describstion": realEstate.description,
      "image": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
      "room_num": realEstate.details.rooms,
      "halls_num": realEstate.details.hall,
      "floor_num": realEstate.details.steps,
      "bulding_age": realEstate.details.old,
      "kitchen": realEstate.details.ketchen ? 1 : 0,
      "car_door": realEstate.details.parking ? 1 : 0,
      "elevator": realEstate.details.elevator ? 1 : 0,
      "Furnished": realEstate.details.mafrosha ? 1 : 0,
      "Conditioners": realEstate.details.airConditioner ? 1 : 0,
      "path_room": realEstate.details.bathroom,
    });
    // try {
    final response = await dio.post(
      url,
      data: data,
      options: Options(
        sendTimeout: 5000,
        receiveTimeout: 5000,
        headers: {
          // 'content-type': 'application/json',
          // 'Accept': 'application/json',
          'Accept': '*/*',
          'content-type': 'multipart/form-data',
        },
      ),
    );

    print("Response Data .........." + response.data.toString());
    print("Response Stause Code .........." + response.statusCode.toString());
    print("Response Message .......... " + response.statusMessage.toString());

    print("Requested Data ........................" +
        response.request.data.toString());
    // } on DioError catch (e) {
    //   print("Catch E " + e.toString());
    //   throw e.message;
    // } catch (e) {
    //   throw e.toString();
    // }
  }
}
