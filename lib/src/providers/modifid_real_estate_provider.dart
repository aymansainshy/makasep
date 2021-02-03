import 'package:flutter/material.dart';
import '../models/real_estate_model.dart';

class ModifiedRealEstat with ChangeNotifier {
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
      hall: 1,
      old: "1",
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

  RealEstate get reatEstate => _realEstate;

  void changHalls(int hall) {
    _realEstate.details.hall = hall;
    notifyListeners();
  }

  void changRooms(int room) {
    _realEstate.details.rooms = room;
    notifyListeners();
  }

  void isElevator(bool isElevator) {
    _realEstate.details.elevator = isElevator;
    notifyListeners();
  }
}
