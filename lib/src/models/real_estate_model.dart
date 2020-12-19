import 'package:flutter/foundation.dart';

import '../models/user_model.dart';

class RealEstate {
  final String id;
  final int type; // 1= apartment , 2= normal house ....
  final User owner;
  final String area; // 40 * 45 M**2
  final double price;
  final String imageUrl;
  final Address address;
  final String description;
  final String categoryType; //1 - all, 2 - Selling .....
  final RealEstateDetails details;

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
  final double lat;
  final double lan;
  final String locationDescription; // Bahry Shambat block 50

  Address({
    @required this.lat,
    @required this.lan,
    @required this.locationDescription,
  });
}

/// [ Real State Details ] ............................
class RealEstateDetails {
  final int rooms;
  final int hall;
  final int bathroom;
  final int steps;
  final String old;
  final bool mafrosha; //mafroshaa
  final bool ketchen;
  final bool parking;
  final bool elevator; //misaad - asanser
  final bool airConditioner;
  final int views;

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
