import 'package:flutter/material.dart';
import './review.dart';

class Place {
  final String name;
  final String desc;
  final String img;
  final String city;
  final int liveCnt;
  final String placeId;
  final String id;
  List<Review> reviews;

  Place({
    @required this.name,
    @required this.desc,
    @required this.img,
    @required this.city,
    @required this.liveCnt,
    @required this.placeId,
    @required this.id,
    @required this.reviews,
  });
}
