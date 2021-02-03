import 'package:flutter/foundation.dart';

class RealEstate with ChangeNotifier {
  String id;
  int type; // 1= apartment , 2= normal house ....
  String owner;
  double area; // 40 * 45 M**2
  double price;
  String imageUrl;
  Address address;
  String description;
  String categoryType; //1 - all, 2 - Selling .....
  RealEstateDetails details;

  RealEstate({
    this.id,
    this.type = 1,
    this.area,
    this.owner,
    this.price,
    this.address,
    this.details,
    this.imageUrl,
    this.description,
    this.categoryType,
  });
}

/// [ Real State Address ] ............................
class Address {
  double lat;
  double lan;
  String locationDescription; // Bahry Shambat block 50

  Address({
    this.lat,
    this.lan,
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
    this.rooms,
    this.hall,
    this.bathroom,
    this.steps,
    this.old,
    this.mafrosha,
    this.ketchen,
    this.parking,
    this.elevator,
    this.airConditioner,
    this.views,
  });
}
