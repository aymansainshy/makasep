import 'package:flutter/cupertino.dart';

class User {
  final String userId;
  final String userName;
  final String imageUrl;
  final double rating;
  final String phoneNumber;
  final String type;

  User({
    @required this.userId,
    @required this.userName,
    @required this.imageUrl,
    @required this.rating,
    @required this.phoneNumber,
    @required this.type,
  });
}
