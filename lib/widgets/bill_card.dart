import '../screens/bill_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../models/bill.dart';

class BillCard extends StatelessWidget {
  final Bill _bill;
  BillCard(this._bill);

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat.yMMMEd('en-US').add_jm().format(_bill.time);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          BillScreen.routeName,
          arguments: _bill,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 12, right: 16, left: 16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          clipBehavior: Clip.antiAlias,
          elevation: 6,
          shadowColor: Theme.of(context).primaryColor.withOpacity(0.5),
          child: ListTile(
            leading: FaIcon(
              FontAwesomeIcons.landmark,
              color: Colors.blueAccent,
            ),
            title: Text('You visited ${_bill.placeName}'),
            subtitle: Text(
              "on $formattedDate ${_bill.numPer > 1 ? '\nwith ${_bill.numPer - 1} others' : ''}",
            ),
            trailing: Container(
                child: Column(
              children: [],
            )),
          ),
        ),
      ),
    );
  }
}
