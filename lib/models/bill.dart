import 'package:flutter/material.dart';

class Bill {
  final String username;
  final String placeName;
  final num numPer;
  final DateTime time;
  final double price;

  Bill({
    @required this.username,
    @required this.placeName,
    @required this.numPer,
    @required this.time,
    @required this.price,
  });
}
