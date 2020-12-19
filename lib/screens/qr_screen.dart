import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/qr_view_example.dart';

class QRScreen extends StatelessWidget {
  static const routeName = '/qr';
  var _mins = 0;
  var _numPeople = 0;
  User _user;
  DocumentReference _userInstance;
  DocumentReference _placeInstance;
  DocumentSnapshot _userData;
  DocumentSnapshot _placeData;

  Future<void> _getUserPlace(placeId) async {
    // Get the Current User Document
    _user = FirebaseAuth.instance.currentUser;
    _userInstance =
        FirebaseFirestore.instance.collection('users').doc(_user.uid);
    _userData = await _userInstance.get();

    // Get the Current Place
    _placeInstance =
        FirebaseFirestore.instance.collection('places').doc(placeId);
    _placeData = await _placeInstance.get();
  }

  void _entry(String placeID, num numTic, BuildContext ctx) async {
    await _getUserPlace(placeID);

    if (_userData['atAPlace'] == true) {
      print('You are already at a Place!');
      return;
    }
    _userInstance.update({
      'atAPlace': true,
      'entryTime': DateTime.now().toIso8601String(),
      'numPer': numTic,
    });

    Navigator.of(ctx).pop();

    // Add to the Livecount of the Place
    _placeInstance.update({
      'liveCnt': _placeData['liveCnt'] + numTic,
    });

    // Show a Popup for the Guard
  }

  void _exit(String placeID, BuildContext ctx) async {
    Navigator.of(ctx).pop();
    await _getUserPlace(placeID);

    if (_userData['atAPlace'] == false) {
      print('You are not present at any Place!');
      return;
    }
    _userInstance.update({
      'atAPlace': false,
    });

    // Finding out the Duration & the Number of People
    final _entryTime = DateTime.parse(_userData['entryTime']);
    Duration d = DateTime.now().difference(_entryTime);
    _mins = d.inMinutes;
    _numPeople = _userData['numPer'];

    // Make a New Bill for the DB (For now, multiplied the fare by minutes, to have a finite, non-zero fair)
    final billDB = {
      'username': _userData['name'],
      'placeName': _placeData['name'],
      'numPer': _numPeople,
      'time': _entryTime.toIso8601String(),
      'price': _placeData['fareHour'] * _mins,
    };
    final newBillsArr = [..._userData['bills'], billDB];
    _userInstance.update({
      'bills': newBillsArr,
    });

    // Subtract from the Livecount of the Place
    _placeInstance.update({
      'liveCnt': _placeData['liveCnt'] - _numPeople,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR'),
        elevation: 0.0,
      ),
      body: QRViewExample(_entry, _exit),
    );
  }
}
