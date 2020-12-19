import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/bill_card.dart';
import '../models/bill.dart';

class BillsScreen extends StatefulWidget {
  static const routeName = '/bills';

  @override
  _BillsScreenState createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  final _bills = [];
  Future<DocumentSnapshot> _userFuture;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _userFuture =
        FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tickets'),
      ),
      body: FutureBuilder(
        future: _userFuture,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }
          print(snap.data['bills']);
          snap.data['bills'].forEach((el) {
            _bills.add(new Bill(
              username: el['username'],
              placeName: el['placeName'],
              numPer: el['numPer'],
              time: DateTime.parse(el['time']),
              price: el['price'],
            ));
          });
          return Container(
            child: ListView.builder(
              itemCount: _bills.length,
              itemBuilder: (ctx, i) {
                return BillCard(_bills[i]);
              },
            ),
          );
        },
      ),
    );
  }
}
