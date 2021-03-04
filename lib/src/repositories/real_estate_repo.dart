import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/secondryType.dart';
import '../models/real_estate_model.dart';
import '../models/user_model.dart';

Dio dio = Dio();

abstract class RealEstateRepo {
  Future<List<RealEstate>> fetchRealEstate(
      String catId, String fliterId, int selectedUrl) {
    return null;
  }

  Future<Map<String, dynamic>> fetchSemilerRealStates(int realEstateId) {
    return null;
  }

  Future<void> postFavoriteRealEstate({
    String usetId,
    int realEstateId,
  }) {
    return null;
  }

  Future<List<RealEstate>> fetchFavoritesRealStates({String userId}) {
    return null;
  }

  Future<void> postRealEstate(
      {String userId, RealEstate realEstate, File image}) {
    return null;
  }

  Future<List<RealEstate>> fetchEspecialRealStates() {
    return null;
  }

  Future<List<RealEstate>> fetchLastCallRealStates(String userId) {
    return null;
  }

  Future<List<RealEstate>> fetchTodayRealStates() {
    return null;
  }

  Future<void> postBuildingAndContract({
    String usetId,
    String phoneNumber,
    String city,
    String description,
    String buildingTypeId,
  }) {
    return null;
  }

  Future<List<SecondryType>> fetchType() {
    return null;
  }
}

class FetchRealEstate extends RealEstateRepo {
  @override
  Future<List<RealEstate>> fetchRealEstate(
      String catId, String fliterId, int selectedUrl) async {
    // print("Cat id //////////////  " + catId);
    // print("Filter id //////////////  " + fliterId);
    // print("Selected Url id //////////////  " + selectedUrl.toString());

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

    try {
      final _response = await dio.get(
        url,
        queryParameters: {
          'primary_type_id': catId,
        },
        options: Options(
          sendTimeout: 5000,
          receiveTimeout: 5000,
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print("Response Body ....  ${_response.data}");

      final _respostDate = _response.data as List<dynamic>;

      List<RealEstate> _loadedRealStates = [];
      _respostDate.forEach((realEstate) {
        _loadedRealStates.add(
          RealEstate.fromJson(realEstate),
        );
      });
      return _loadedRealStates;
    } on DioError catch (e) {
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
      throw DioError(error: e);
    }
  }

  @override
  Future<List<RealEstate>> fetchEspecialRealStates() async {
    final url = 'http://162.0.230.58/api/realEstate/special';

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

      final _respostDate = _response.data as List<dynamic>;

      List<RealEstate> _loadedRealStates = [];
      _respostDate.forEach(
        (e) {
          _loadedRealStates.add(
            RealEstate.fromJson(e),
          );
        },
      );

      return _loadedRealStates;
    } on DioError catch (e) {
      throw DioError(error: e);
    }
  }

  @override
  Future<List<RealEstate>> fetchLastCallRealStates(String userId) async {
    final url = 'http://162.0.230.58/api/realEstate/lastViewed/$userId';

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

      final _respostDate = _response.data as List<dynamic>;

      List<RealEstate> _loadedRealStates = [];
      _respostDate.forEach(
        (e) {
          _loadedRealStates.add(
            RealEstate.fromJson(e["real_estate"]),
          );
        },
      );

      return _loadedRealStates;
    } on DioError catch (e) {
      throw DioError(error: e);
    }
  }

  @override
  Future<List<RealEstate>> fetchTodayRealStates() async {
    final url = 'http://162.0.230.58/api/realEstate/today';

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

      final _respostDate = _response.data as List<dynamic>;

      List<RealEstate> _loadedRealStates = [];
      _respostDate.forEach(
        (e) {
          _loadedRealStates.add(
            RealEstate.fromJson(e),
          );
        },
      );

      return _loadedRealStates;
    } on DioError catch (e) {
      throw DioError(error: e);
    }
  }
}

class FetchSimelarRealEstate extends RealEstateRepo {
  @override
  Future<Map<String, dynamic>> fetchSemilerRealStates(int realEstateId) async {
    final url = 'http://162.0.230.58/api/realestate/$realEstateId';

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

      Map<String, dynamic> realEstateById = {};

      final _respostDate = _response.data['same'] as List<dynamic>;
      final _respostUserData =
          _response.data['real_state']['user'] as Map<dynamic, dynamic>;

      final User userData = User(
        userId: _respostUserData["id"].toString(),
        imageUrl: _respostUserData["image"] == null
            ? null
            : 'http://162.0.230.58${_respostUserData["image"]}',
        phoneNumber: _respostUserData["phone_number"].toString(),
        showContct: _respostUserData["show_contact"].toString(),
        rating: double.parse(_respostUserData["rating"].toString()),
        userName: _respostUserData["user_name"],
        userType: _respostUserData["user_type_id"],
      );

      final List<RealEstate> loadedRealStates = [];

      _respostDate.forEach(
        (e) {
          loadedRealStates.add(
            RealEstate.fromJson(e),
          );
        },
      );

      realEstateById["semilarRealEstate"] = loadedRealStates;
      realEstateById["userData"] = userData;

      return realEstateById;
    } on DioError catch (e) {
      throw DioError(error: e);
    }
  }
}

class PostRealEstate extends RealEstateRepo {
  @override
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
      "floor_num": realEstate.details.steps == 0
          ? realEstate.details.steps
          : realEstate.details.steps - 1,
      "bulding_age": realEstate.details.old,
      "kitchen": realEstate.details.ketchen ? 1 : 0,
      "car_door": realEstate.details.parking ? 1 : 0,
      "elevator": realEstate.details.elevator ? 1 : 0,
      "Furnished": realEstate.details.mafrosha ? 1 : 0,
      "Conditioners": realEstate.details.airConditioner ? 1 : 0,
      "path_room": realEstate.details.bathroom,
    });
    try {
      await dio.post(
        url,
        data: data,
        options: Options(
          sendTimeout: 6000,
          receiveTimeout: 6000,
          headers: {
            'Accept': '*/*',
            'content-type': 'multipart/form-data',
          },
        ),
        onSendProgress: (sent, total) {
          print("Sent : [ ${(sent / total) * 100} ] from : [ 100\% ] ....");
        },
      );
    } on DioError catch (e) {
      throw DioError(error: e);
    }
  }
}

class FavoriteRealEstatePost extends RealEstateRepo {
  @override
  Future<void> postFavoriteRealEstate({
    String usetId,
    int realEstateId,
  }) async {
    final url = 'http://162.0.230.58/api/Customer/$usetId/favorit';

    Map<String, dynamic> data = {
      "real_estate_id": realEstateId,
    };
    try {
      await dio.post(
        url,
        data: jsonEncode(data),
        options: Options(
          sendTimeout: 5000,
          receiveTimeout: 5000,
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } on DioError catch (e) {
      throw DioError(error: e);
    }
  }
}

class FetchFavoritRealEState extends RealEstateRepo {
  @override
  Future<List<RealEstate>> fetchFavoritesRealStates({String userId}) async {
    final url = 'http://162.0.230.58/api/Customer/$userId/favorit';
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

      final _respostDate = _response.data as List<dynamic>;

      List<RealEstate> _loadedRealStates = [];
      _respostDate.forEach(
        (e) {
          _loadedRealStates.add(
            RealEstate.fromJson(e["real_estate"]),
          );
        },
      );

      return _loadedRealStates;
    } on DioError catch (e) {
      throw DioError(error: e);
    }
  }
}

class BuildingAndContract extends RealEstateRepo {
  @override
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
    try {
      await dio.post(
        url,
        data: jsonEncode(data),
        options: Options(
          sendTimeout: 5000,
          receiveTimeout: 5000,
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } on DioError catch (e) {
      throw DioError(error: e);
    }
  }
}

class FetchType extends RealEstateRepo {
  @override
  Future<List<SecondryType>> fetchType() async {
    final url = 'http://162.0.230.58/api/secondry';
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

      final _respostDate = _response.data as List<dynamic>;

      List<SecondryType> _loadedType = [];
      _respostDate.forEach(
        (e) {
          _loadedType.add(
            SecondryType.fromJson(e),
          );
        },
      );

      return _loadedType;
    } on DioError catch (e) {
      // if (e.response != null) {
      //   print("RESPONSE Error Respons Data == " + e.response.data.toString());
      //   print("RESPONSE Error Respons Status massege == " +
      //       e.response.statusMessage.toString());
      //   print("RESPONSE Error Response Request == " +
      //       e.response.request.uri.toString());
      // }
      // print("ERROR Error error == " + e.error.toString());
      // print("ERROR Error request == " + e.request.uri.toString());
      // print("ERROR Error type == " + e.type.toString());
      // print("ERROR Error massege == " + e.message.toString());
      throw DioError(error: e);
    }
  }
}
