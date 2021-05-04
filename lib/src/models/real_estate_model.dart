import 'package:flutter/foundation.dart';

class RealEstate {
  int id;
  String type; // 1= apartment , 2= normal house ....
  String owner;
  String area; // 40 * 45 M**2
  double price;
  String imageUrl;
  Address address;
  String description;
  String categoryType; //1 - all, 2 - Selling .....
  RealEstateDetails details;

  RealEstate({
    @required this.id,
    @required this.type,
    @required this.area,
    @required this.owner,
    @required this.price,
    @required this.address,
    @required this.details,
    @required this.imageUrl,
    @required this.description,
    @required this.categoryType,
  });

  factory RealEstate.fromJson(Map<String, dynamic> json) {
    return RealEstate(
      id: json["id"],
      categoryType: json["primary_type_id"].toString(),
      price: double.parse(json["price"].toString()),
      owner: json["user_id"],
      area: json["space"],
      description: json["describstion"],
      imageUrl: json["image"],
      type: json["secondry_type_id"],
      address: Address(
        lat: json["lat"],
        lan: json["long"],
      ),
      details: RealEstateDetails(
        hall: json["halls_num"],
        rooms: json["room_num"],
        views: json["watching_time"],
        old: json["bulding_age"],
        steps: json["floor_num"],
        bathroom: json["path_room"],
        airConditioner: json["Conditioners"] == 0 ? false : true,
        elevator: json["elevator"] == 0 ? false : true,
        ketchen: json["kitchen"] == 0 ? false : true,
        parking: json["car_door"] == 0 ? false : true,
        mafrosha: json["Furnished"] == 0 ? false : true,
      ),
    );
  }
}

/// [ Real State Address ] ............................
class Address {
  double lat;
  double lan;
  String locationDescription; // Bahry Shambat block 50

  Address({
    @required this.lat,
    @required this.lan,
    this.locationDescription,
  });
}

/// [ Real State Details ] ............................
class RealEstateDetails {
  int rooms;
  int hall = 1;
  int bathroom;
  int steps;
  int old;
  int views;
  bool mafrosha; //mafroshaa
  bool ketchen;
  bool parking;
  bool elevator; //misaad - asanser
  bool airConditioner;

  RealEstateDetails({
    @required this.rooms,
    @required this.hall,
    @required this.bathroom,
    @required this.steps,
    @required this.old,
    @required this.mafrosha,
    @required this.ketchen,
    @required this.parking,
    @required this.elevator,
    @required this.airConditioner,
    @required this.views,
  });
}
