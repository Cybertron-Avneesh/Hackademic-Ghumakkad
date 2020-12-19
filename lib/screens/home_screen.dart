import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './qr_screen.dart';
import './bills_screen.dart';
import '../widgets/all_cities.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future _citiesFuture = FirebaseFirestore.instance.collection('cities').get();
  final List<Map<String, String>> _cities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // add logout functionality
              FirebaseAuth.instance.signOut();
            },
          ),
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {
              Navigator.of(context).pushNamed(QRScreen.routeName);
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _citiesFuture,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // snap.data.docs.forEach((el) => _cities.add(el['name']));
          snap.data.docs.forEach((el) {
            _cities.add({
              'id': el.id,
              'name': el['name'],
            });
          });
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  Theme.of(context).primaryColor,
                  Colors.transparent,
                ],
              ),
            ),
            child: AllCities(_cities),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(BillsScreen.routeName);
        },
        label: Text('All Tickets'),
        icon: Icon(Icons.payment),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
