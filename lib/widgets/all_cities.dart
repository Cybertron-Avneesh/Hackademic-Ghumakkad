import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import '../widgets/dropdown.dart';
// import '../widgets/place_card.dart';
import '../models/place.dart';
import '../models/review.dart';

class AllCities extends StatefulWidget {
  final cities;
  AllCities(this.cities);

  @override
  _AllCitiesState createState() => _AllCitiesState();
}

class _AllCitiesState extends State<AllCities> {
  Future _placesFuture = FirebaseFirestore.instance.collection('places').get();
  final _places = [];
  var _selectedCityId = '';
  var _selectedPlaces = [];
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _placesFuture.then((data) {
      data.docs.forEach((el) {
        final newPlace = Place(
          name: el['name'],
          desc: el['desc'],
          img: el['img'],
          city: el['city'],
          liveCnt: el['liveCnt'],
          placeId: el['placeId'],
          reviews: [],
          id: el.id,
        );
        el['reviews'].forEach(
          (re) => newPlace.reviews.add(
            Review(desc: re['desc'], name: re['name'], rating: re['rating']),
          ),
        );
        _places.add(newPlace);
      });
    });
    setState(() {
      _isLoading = false;
    });
  }

  void _setCity(val) {
    if (val != _selectedCityId) {
      _selectedCityId = val;
      _selectedPlaces.clear();
      _places.forEach((el) {
        if (el.placeId == _selectedCityId) {
          _selectedPlaces.add(el);
        }
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
      ],
    );
  }
}
