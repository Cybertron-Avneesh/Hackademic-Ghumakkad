import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
            // child: AllCities(_cities),
            child: Text("Cities to be shown here."),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Start Exploring'),
        icon: Icon(Icons.explore),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
