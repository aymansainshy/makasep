import 'package:flutter/foundation.dart';

class RealEstate {
  String id;
  int type; // 1= apartment , 2= normal house ....
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
  String old;
  bool mafrosha; //mafroshaa
  bool ketchen;
  bool parking;
  bool elevator; //misaad - asanser
  bool airConditioner;
  int views;

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
