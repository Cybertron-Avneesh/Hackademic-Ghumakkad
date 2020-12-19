import 'package:flutter/material.dart';

class Review {
  final String desc;
  final String name;
  final double rating;

  Review({
    @required this.desc,
    @required this.name,
    @required this.rating,
  });
}
