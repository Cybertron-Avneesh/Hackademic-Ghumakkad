import 'package:flutter/material.dart';

import '../screens/bill_screen.dart';
import '../models/bill.dart';

class BillCard extends StatelessWidget {
  final Bill _bill;
  BillCard(this._bill);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          BillScreen.routeName,
          arguments: _bill,
        );
      },
      child: Container(
        margin: EdgeInsets.all(20),
        height: 100,
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Text(_bill.placeName),
          ],
        ),
      ),
    );
  }
}
