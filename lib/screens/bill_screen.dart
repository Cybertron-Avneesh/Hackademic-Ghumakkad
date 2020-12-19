import 'package:flutter/material.dart';

import '../models/bill.dart';

class BillScreen extends StatelessWidget {
  static const routeName = '/bill';

  @override
  Widget build(BuildContext context) {
    final _bill = ModalRoute.of(context).settings.arguments as Bill;
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Screen'),
      ),
    );
  }
}
