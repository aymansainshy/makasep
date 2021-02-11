import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/real_estate_model.dart';

class ModifiedRealEstat with ChangeNotifier {
  RealEstate _realEstate = RealEstate(
    id: "",
    area: "0.0",
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

  File _storedImage;

  final _picker = ImagePicker();

  Future picImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _storedImage = File(pickedFile.path);
      notifyListeners();
    } else {
      print('No image selected.');
    }
  }

  File get storedImage {
    return _storedImage;
  }

  void setAdderess(Map<String, dynamic> address) {
    _realEstate.address = Address(
      lan: address["lan"],
      lat: address["lat"],
    );
    notifyListeners();
  }

  void setCatType(String catId) {
    _realEstate.categoryType = catId;
    notifyListeners();
  }

  void setArea(String area) {
    _realEstate.area = area;
    notifyListeners();
  }

  void setDescription(String description) {
    _realEstate.description = description;
    notifyListeners();
  }

  void setPrice(double price) {
    _realEstate.price = price;
    notifyListeners();
  }

  void setType(int typeId) {
    _realEstate.type = typeId;
    notifyListeners();
  }

  void setAdress() {
    notifyListeners();
  }

  void changHalls(int hall) {
    _realEstate.details.hall = hall;
    notifyListeners();
  }

  void setBathRooms(int bathroom) {
    _realEstate.details.bathroom = bathroom;
    notifyListeners();
  }

  void changRooms(int room) {
    _realEstate.details.rooms = room;
    notifyListeners();
  }

  void setOld(String old) {
    _realEstate.details.old = old;
    notifyListeners();
  }

  void setSteps(int steps) {
    _realEstate.details.steps = steps;
    notifyListeners();
  }

  void isElevator(bool isElevator) {
    _realEstate.details.elevator = isElevator;
    notifyListeners();
  }

  void isKetchen(bool isKetchen) {
    _realEstate.details.ketchen = isKetchen;
    notifyListeners();
  }

  void isMafroshe(bool isMafroshe) {
    _realEstate.details.mafrosha = isMafroshe;
    notifyListeners();
  }

  void isParking(bool isParking) {
    _realEstate.details.parking = isParking;
    notifyListeners();
  }

  void isAirConditions(bool isconditions) {
    _realEstate.details.airConditioner = isconditions;
    notifyListeners();
  }

  void reaSet() {
    RealEstate _newRealEstate = RealEstate(
      id: "",
      area: "0.0",
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

    _realEstate = _newRealEstate;
    _storedImage = null;
    notifyListeners();
  }
}
